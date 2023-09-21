require "csv"

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end

  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
    @percentage_results = nil
  end

  ###=== GLOBAL HELPERS ===###
  def team_name_from_id(team_id)
    @teams_data.each do |tm|
      return tm[:teamname] if tm[:team_id] == team_id
    end
  end

  ###=== GLOBAL HELPERS ===###

  ###=== GAME QUERIES ===###
  ##== GAME HELPERS ==##
  def total_scores
    @games_data.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }
  end

  ##== GAME HELPERS ==##
  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def percentage_results
    if @percentage_results.nil?
      @percentage_results = {}
      number_games = @games_data.length

      home_wins = @games_data.count { |game| game[:home_goals].to_i > game[:away_goals].to_i }

      @percentage_results[:home_wins] = (home_wins.to_f / number_games * 100.0).round(2)

      away_wins = @games_data.count { |game| game[:away_goals].to_i > game[:home_goals].to_i }

      @percentage_results[:away_wins] = (away_wins.to_f / number_games * 100.0).round(2)

      ties = @games_data.count { |game| game[:away_goals].to_i == game[:home_goals].to_i }

      @percentage_results[:ties] = (ties.to_f / number_games * 100.0).round(2)
    end

    @percentage_results
  end

  def percentage_home_wins
    percentage_results[:home_wins]
  end

  def percentage_visitor_wins
    percentage_results[:away_wins]
  end

  def percentage_ties
    percentage_results[:ties]
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @games_data.each do |game|
      season = game[:season]
      games_by_season[season] += 1
    end

    games_by_season
  end

  def average_goals_per(interval)
    # if interval argument ==  :game {total: [goals_per_game]}
    # if interval argument == :season { season: [goals_per_game] }
    goals_by_interval = Hash.new { |hash, key| hash[key] = [] }

    @games_data.each do |game|
      if interval == :season
        goals_by_interval[game[:season]] << game[:home_goals].to_i + game[:away_goals].to_i
      else
        goals_by_interval[:total] << game[:home_goals].to_i + game[:away_goals].to_i
      end
    end

    goals_by_interval.transform_values! do |game_goals|
      (game_goals.reduce(:+) / game_goals.size.to_f).round(2)
    end

    # { interval: avg_goals }
    goals_by_interval
  end

  def average_goals_per_game
    average_goals_per(:game)[:total]
  end

  def average_goals_per_season
    average_goals_per(:season)
  end

  ###=== GAME QUERIES ===###

  ###=== LEAGUE QUERIES ===###
  ##== LEAGUE HELPERS ==##
  # return: hash of all for all seasons { team_id => [goals] } => after reduce { team_id => avg_goals }
  def team_avg_goals(filter = nil, value = nil)
    team_goals = Hash.new { |hash, key| hash[key] = [] }

    @game_teams_data.each do |game|
      if filter.nil?
        team_goals[game[:team_id]] << game[:goals].to_i
      elsif game[filter] == value
        team_goals[game[:team_id]] << game[:goals].to_i
      end
    end

    team_goals.transform_values! do |goals|
      (goals.reduce(:+) / goals.size.to_f).round(2)
    end

    team_goals
  end

  ##== LEAGUE HELPERS ==##

  def count_of_teams
    teams_data.size
  end

  def best_offense
    team_id = team_avg_goals.max_by { |k, v| v }[0]  # max => [team_id, value] from hash

    team_name_from_id(team_id)
  end

  def worst_offense
    team_id = team_avg_goals.min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def highest_scoring_visitor
    team_id = team_avg_goals(:hoa, "away").max_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def highest_scoring_home_team
    team_id = team_avg_goals(:hoa, "home").max_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def lowest_scoring_visitor
    team_id = team_avg_goals(:hoa, "away").min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def lowest_scoring_home_team
    team_id = team_avg_goals(:hoa, "home").min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  ###=== LEAGUE QUERIES ===###

  ###=== SEASON QUERIES ===###
  ##== SEASON HELPERS ==##

  def coach_season_win_pct(season)
    season_games = []

    @games_data.each do |game|
      season_games << game[:game_id] if game[:season] == season
    end
    # iterate over @game_teams_mock to verify :game_id is .include? in predicate array
    # if :game_id is valid, use :head_coach name as hash key, and shovel :result onto hash value array
    coach_results = Hash.new { |hash, key| hash[key] = [] }
    @game_teams_data.each do |team_game|
      if season_games.include?(team_game[:game_id]) # game is in the queried season
        coach_results[team_game[:head_coach]] << team_game[:result]
      end
    end
    # with hash values arrays, use #transform_values! to reduce to win pct.
    coach_results.transform_values! do |results|
      (results.count("WIN") / results.size.to_f * 100.0).round(2)
    end
    coach_results
  end

  def team_accuracies(season)
    team_accuracies = Hash.new { |hash, key| hash[key] = [] }  # {team_id: [goals, shots]}
    # array of hashes, each hash is data for a game team for specific season.
    # [{CSV::Row from game_teams_data}]
    game_teams_in_season = @game_teams_data.select do |game_team|
      game_id = game_team[:game_id]
      game = @games_data.find { |game| game[:game_id] == game_id }

      game && game[:season] == season
    end

    game_teams_in_season.each do |game_team|
      team_id = game_team[:team_id]
      goals = game_team[:goals].to_i
      shots = game_team[:shots].to_i

      team_accuracies[team_id] << goals.to_f / shots
    end

    team_accuracies.transform_values! do |ratios|
      (ratios.reduce(:+) / ratios.size).round(2)
    end
    team_accuracies
  end

  def season_team_tackles(season)
    season_team_tackles = Hash.new(0)

    @games_data.each do |game|
      if game[:season] == season
        game_id = game[:game_id]
        @game_teams_data.each do |game_team|
          if game_team[:game_id] == game_id
            team_id = game_team[:team_id]
            season_team_tackles[team_id] += game_team[:tackles].to_i
          end
        end
      end
    end

    season_team_tackles
  end

  ##== SEASON HELPERS ==##

  # @season: string of season year start finish: YYYYYYYY
  # @return: name of coach with highest winning pct.
  def winningest_coach(season)
    coach_results = coach_season_win_pct(season)

    coach_results.max_by { |k, v| v }[0]
  end

  def worst_coach(season)
    coach_results = coach_season_win_pct(season)

    coach_results.min_by { |k, v| v }[0]
  end

  def most_accurate_team(season)
    most_accurate_team = team_accuracies(season).max_by { |_, ratio| ratio }

    team_name_from_id(most_accurate_team[0])
  end

  def least_accurate_team(season)
    least_accurate_team = team_accuracies(season).min_by { |_, ratio| ratio }

    team_name_from_id(least_accurate_team[0])
  end

  def most_tackles(season)
    max_team_tackles = season_team_tackles(season).max_by { |_, tackles| tackles }

    team_name_from_id(max_team_tackles[0])
  end

  def fewest_tackles(season)
    low_team_tackles = season_team_tackles(season).min_by { |_, tackles| tackles }

    team_name_from_id(low_team_tackles[0])
  end
  ###=== SEASON QUERIES ===###
end
