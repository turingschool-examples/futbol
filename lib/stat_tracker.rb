require 'csv'
require 'pry'
require_relative './team_stats.rb'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  include TeamStats

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

  def count_of_teams
    @teams.length
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


end
