require 'csv'
require 'pry'
require_relative './league_stats'
class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  include LeagueStats

  def highest_total_score
    # highest sum of winning and losing teams scores
    sum_goals_array = @games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    sum_goals_array.max
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game[:home_goals] > game[:away_goals]
    end
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game[:home_goals] < game[:away_goals]
    end
    (visitor_wins.to_f / @games.length).round(2)
  end

  def lowest_total_score
    sum_goals_array = @games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    sum_goals_array.min
  end

  def percentage_ties
    # Percentage of games that have resulted in a tie rounded to the nearest 100th
    results = return_column(@game_teams, :result)
    tie_results = results.find_all { |result| result == "TIE"}
    (tie_results.length.to_f / results.length.to_f).round(2)
  end

  def average_goals_per_game
    goals_array = @games.map do |game|
      game[:home_goals].to_f + game[:away_goals].to_f
    end
    sum_goals_array = goals_array.sum
    (sum_goals_array / @games.length).round(2)
  end

  def return_column(data_set, column)
    all_results = []
    data_set.each do |rows|
      all_results << rows[column]
    end
    all_results
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

  # could this be re-factored to accept an optional argument equal to :teamname?
  def average_goals_by_season # mm
    szns = Hash.new { |h,k| h[k] = [] }

    @games.each do |csv_row|
      szns[csv_row[:season]] << csv_row[:away_goals].to_i + csv_row[:home_goals].to_i
    end

    szns.each do |k,v|
      szns[k] = (szns[k].sum / szns[k].count.to_f).round(2)
    end
    szns
  end

  def count_of_games_by_season
    count = Hash.new(0)
    @games.each do |game|
      count[game[:season]] += 1
    end
    count
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
