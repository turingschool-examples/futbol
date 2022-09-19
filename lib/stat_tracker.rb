require 'csv'
require 'pry'
require_relative './game_statistics'
class StatTracker
  include Game_statistics
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  

  def count_of_teams
    @teams.length
  end

  def self.from_csv(locations)
    games = CSV.open locations[:games], headers: true, header_converters: :symbol
    teams = CSV.open locations[:teams], headers: true, header_converters: :symbol
    game_teams = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    make_rows([games, teams, game_teams])
  end

  def self.make_rows(array)
    dummy_array = array.map do |file|
      file.map do |row|
        row
      end
    end
    StatTracker.new(dummy_array[0], dummy_array[1], dummy_array[2])
  end

  def average_win_percentage(team_id)
    games_played = @game_teams.count { |row| row[:team_id] == team_id.to_s }
    games_won = @game_teams.count { |row| row[:team_id] == team_id.to_s && row[:result] == 'WIN'}
    (games_won.to_f / games_played).round(2)
  end

  def most_accurate_team(season)
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3])}

    team_shots_goals = Hash.new({shots: 0, goals: 0})
    season_games.each do |game|
      team_shots_goals.default = {shots: 0, goals: 0}
      team_shots_goals[game[:team_id]] = {
        shots: team_shots_goals[game[:team_id]][:shots] += game[:shots].to_i,
        goals: team_shots_goals[game[:team_id]][:goals] += game[:goals].to_i
      }
    end
    team_id = team_shots_goals.max_by do |team, stats|
      stats[:goals].to_f / stats[:shots]
    end
    team_finder(team_id[0])
  end

  def least_accurate_team(season)
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3])}

    team_shots_goals = Hash.new({shots: 0, goals: 0})
    season_games.each do |game|
      team_shots_goals.default = {shots: 0, goals: 0}
      team_shots_goals[game[:team_id]] = {
        shots: team_shots_goals[game[:team_id]][:shots] += game[:shots].to_i,
        goals: team_shots_goals[game[:team_id]][:goals] += game[:goals].to_i
      }
    end
    team_id = team_shots_goals.min_by do |team, stats|
      stats[:goals].to_f / stats[:shots]
    end
    team_finder(team_id[0])
  end

  def most_tackles(season)
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3])}
    team_tackles = Hash.new(0)
    season_games.each do |game|
       team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    team_id = team_tackles.max_by { |team_id, tackles| tackles }
    team_finder(team_id[0])
  end

  def fewest_tackles(season)
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3])}
    team_tackles = Hash.new(0)
    season_games.each do |game|
       team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    team_id = team_tackles.min_by { |team_id, tackles| tackles }
    team_finder(team_id[0])
  end


  def team_finder(team_id)
    @teams.find { |team| team[:team_id] == team_id }[:teamname]
  end

  def favorite_opponent(team_id)
    wins_hash = Hash.new { |h,k| h[k] = [] }
    all_games_played = @games.find_all { |game| [game[:home_team_id], game[:away_team_id]].include?(team_id) }

    all_games_played.each do |game|
      opponent = [game[:home_team_id], game[:away_team_id]].find{ |team| team != team_id }
      wins_hash[opponent] << game[:game_id]
    end

    wins_hash.each do |opponent, game_ids|
      wins_hash[opponent] = game_ids.map do |game_id|
        row = @game_teams.find { |game| game[:game_id] == game_id && game[:team_id] == team_id.to_s }
        row[:result]
      end
    end

    fave_opp_id = wins_hash.max_by { |key, value| value.count { |result| result == 'WIN'}.to_f / value.length }[0]

    team_finder(fave_opp_id)
  end

  def rival(team_id)
    wins_hash = Hash.new { |h,k| h[k] = [] }
    all_games_played = @games.find_all { |game| [game[:home_team_id], game[:away_team_id]].include?(team_id.to_s) }

    all_games_played.each do |game|
      opponent = [game[:home_team_id], game[:away_team_id]].find{ |team| team != team_id }
      wins_hash[opponent] << game[:game_id]
    end

    wins_hash.each do |key, value|
      wins_hash[key] = value.map do |game_id|
        row = @game_teams.find { |game| game[:game_id] == game_id && game[:team_id] == team_id.to_s }
        row[:result]
      end
    end

    opp_id = wins_hash.min_by { |key, value| value.count { |result| result == 'WIN'}.to_f / value.length }[0]

    team_finder(opp_id)
  end

  def best_offense # mm
    # hash to store {team_id => avg goals/game}
    team_id_goals_hash = Hash.new { |h, k| h[k] = [] }
    # turn CSV::Rows => Hashes
    game_teams_hash_elements = @game_teams.map(&:to_h)
    # iterate through the Hash elements
    game_teams_hash_elements.each do |x|
      # create team_id keys => array of goals scored
      team_id_goals_hash[x[:team_id]] << x[:goals].to_i
    end
    # turn the value arrays => avg goals/game
    team_id_goals_hash.map do |k,v|
      team_id_goals_hash[k] = (v.sum / v.length.to_f).round(2)
    end

    # find @teams the team_id that corresponds to the maximum value in the team_id_goals_hash
    @teams.find { |x| x.fetch(:team_id) == team_id_goals_hash.max_by { |k,v| v }.first }[:teamname]
  end

  def worst_offense # mm
    # hash to store {team_id => avg goals/game}
    team_id_goals_hash = Hash.new { |h, k| h[k] = [] }
    # turn CSV::Rows => Hashes
    game_teams_hash_elements = @game_teams.map(&:to_h)
    # iterate through the Hash elements
    game_teams_hash_elements.each do |x|
      # create team_id keys => array of goals scored
      team_id_goals_hash[x[:team_id]] << x[:goals].to_i
    end
    # turn the value arrays => avg goals/game
    team_id_goals_hash.map do |k,v|
      team_id_goals_hash[k] = (v.sum / v.length.to_f).round(2)
    end

    # find @teams the team_id that corresponds to the maximum value in the team_id_goals_hash
    @teams.find { |x| x.fetch(:team_id) == team_id_goals_hash.min_by { |k,v| v }.first }[:teamname]
  end

  def winningest_coach(season) #mm
    szn = season.to_s[0..3]
    szn_game_results = @game_teams.select { |game| game[:game_id][0..3] == szn }
    # the hash
    coaches_hash = Hash.new { |h,k| h[k] = [] }
    # group the coaches with their results
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    # convert the values to winning percentages
    win_pct = coaches_hash.each do |k,v|
      # for a given coach, divide wins(float) by total games and round to 3 decimal places
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == "WIN" }.count.to_f / coaches_hash[k].count).round(3)
    end
    # win_pct
    # find the best
    winningest = win_pct.max_by { |k,v| v }
    # return the name
    winningest.first
  end

  def worst_coach(season) # mm
    szn = season.to_s[0..3]
    szn_game_results = @game_teams.select { |game| game[:game_id][0..3] == szn }
    # a hash to be populated
    coaches_hash = Hash.new { |h,k| h[k] = [] }
    # group the coaches with their results arrays
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    # convert the values to winning percentages
    win_pct = coaches_hash.each do |k,v|
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == "WIN" }.count.to_f / coaches_hash[k].count).round(3)
    end
    # find the worst
    worst = win_pct.min_by { |k,v| v }
    # put him on blast
    worst.first
  end

  def most_goals_scored(team_id) # mm
    # find all games for team_id, turn them into the goals scored, grab the max, 2 eyes
    @game_teams.find_all { |x| x[:team_id] == team_id.to_s }.map { |x| x[:goals] }.max.to_i
  end

  def fewest_goals_scored(team_id) ## mm
    # find all games for team_id, turn them into the goals scored, grab the min, 2 eyes
    @game_teams.find_all { |x| x[:team_id] == team_id.to_s }.map { |x| x[:goals] }.min.to_i
  end

  def highest_scoring_visitor
    away_team_score = Hash.new(0)
    away_team_count = Hash.new(0)
    @games.map do |game|
      away_team_score[game[:away_team_id]] += game[:away_goals].to_i
      away_team_count[game[:away_team_id]] += 1
    end
    away_score_average = away_team_score.map do |id, score|
      {id => (score.to_f / away_team_count[id].to_f).round(2)}
    end
    away_score_hash = {}
    away_score_average.each do |average|
      away_score_hash[average.keys[0]] = average.values[0]
    end
    team_id_highest_average = away_score_hash.key(away_score_hash.values.max)

    team_highest_average = @teams.find do |team|
      team[:team_id] == team_id_highest_average
    end
    team_highest_average[:teamname]
  end

  def lowest_scoring_visitor
    away_team_score = Hash.new(0)
    away_team_count = Hash.new(0)
    @games.map do |game|
      away_team_score[game[:away_team_id]] += game[:away_goals].to_i
      away_team_count[game[:away_team_id]] += 1
    end
    away_score_average = away_team_score.map do |id, score|
      {id => (score.to_f / away_team_count[id].to_f).round(2)}
    end
    away_score_hash = {}
    away_score_average.each do |average|
      away_score_hash[average.keys[0]] = average.values[0]
    end
    team_id_lowest_average = away_score_hash.key(away_score_hash.values.min)

    team_lowest_average = @teams.find do |team|
      team[:team_id] == team_id_lowest_average
    end
    team_lowest_average[:teamname]
  end

  def highest_scoring_home_team
    home_team_score = Hash.new(0)
    home_team_count = Hash.new(0)
    @games.map do |game|
      home_team_score[game[:home_team_id]] += game[:home_goals].to_i
      home_team_count[game[:home_team_id]] += 1
    end
    home_score_average = home_team_score.map do |id, score|
      {id => (score.to_f / home_team_count[id].to_f).round(2)}
    end
    home_score_hash = {}
    home_score_average.each do |average|
      home_score_hash[average.keys[0]] = average.values[0]
    end
    team_id_highest_average = home_score_hash.key(home_score_hash.values.max)

    team_highest_average = @teams.find do |team|
      team[:team_id] == team_id_highest_average
    end
    team_highest_average[:teamname]
  end

  def lowest_scoring_home_team
    home_team_score = Hash.new(0)
    home_team_count = Hash.new(0)
    @games.map do |game|
      home_team_score[game[:home_team_id]] += game[:home_goals].to_i
      home_team_count[game[:home_team_id]] += 1
    end
    home_score_average = home_team_score.map do |id, score|
      {id => (score.to_f / home_team_count[id].to_f).round(2)}
    end
    home_score_hash = {}
    home_score_average.each do |average|
      home_score_hash[average.keys[0]] = average.values[0]
    end
    team_id_lowest_average = home_score_hash.key(home_score_hash.values.min)

    team_lowest_average = @teams.find do |team|
      team[:team_id] == team_id_lowest_average
    end
    team_lowest_average[:teamname]
  end

  def team_info(id)
  info = {}
  team = @teams.find { |team_row| team_row[:team_id] == id}
  info['team_id'] = team[:team_id]
  info['franchise_id'] = team[:franchiseid]
  info['team_name'] = team[:teamname]
  info['abbreviation'] = team[:abbreviation]
  info['link'] = team[:link]
  info
  # require 'pry'; binding.pry
  end

  #helper method for best/worst season
  def find_all_games_for_a_team(team_id)
     @games.find_all do |game|
      (game[:home_team_id] == team_id) || (game[:away_team_id] == team_id) 
     end
  end
  #helper method for best/worst season
  def games_grouped_by_season(all_games)
    all_games.group_by do |game|
      game[:season]
    end
  end

  #helper method for best/worst season
  def season_game_count(season_games)
    game_count = Hash.new(0)
    season_games.each do |season, games|
      game_count[season] = games.length
    end
    game_count
  end
  #helper method for best/worst season
  def wins_count(season_games, team_id)
    wins_count = Hash.new(0)
    season_games.map do |season, games|
      games.map do |game|
        @game_teams.map do |game_team|
          if game_team[:game_id] == game[:game_id] && game_team[:team_id] == team_id && game_team[:result] == "WIN"
                wins_count[season] = 1 if wins_count[season].nil?
                wins_count[season] += 1 if !wins_count[season].nil?
          else 
            next
          end
        end
      end
    end
    wins_count
  end
  #helper method for best/worst season
  def win_percent_by_season(wins_count, season_game_count)
    season_game_count.merge(wins_count) do |season, game_count, wins_count|
      # binding.pry
      ((wins_count.to_f / game_count) * 100).round(2)
    end
  end
  #helper method for best/worst season
  def season_win_percentage(win_percent_by_season, use_max)
    if use_max
      result = win_percent_by_season.max_by do |season, percentage|
        percentage
      end
    else 
      result = win_percent_by_season.min_by do |season, percentage|
      percentage
    end
    end
    result[0]
  end
  
  def best_season(team_id)
    all_games = find_all_games_for_a_team(team_id)
    season_games = games_grouped_by_season(all_games)
    season_game_count = season_game_count(season_games)
    wins_count = wins_count(season_games, team_id)
    win_percent_by_season = win_percent_by_season(wins_count, season_game_count)
     season_win_percentage(win_percent_by_season, true)
    #  binding.pry
  end

  def worst_season(team_id)
    all_games = find_all_games_for_a_team(team_id)
    season_games = games_grouped_by_season(all_games)
    season_game_count = season_game_count(season_games)
    wins_count = wins_count(season_games, team_id)
    win_percent_by_season = win_percent_by_season(wins_count, season_game_count)
     season_win_percentage(win_percent_by_season, false)
  end
end
