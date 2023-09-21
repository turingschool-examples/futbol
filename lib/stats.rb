class Stats 
  attr_reader :games_data, :teams_data, :game_teams_data

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

  ##== GAME HELPERS ==##

  # Returns an array with elements of total points scored each game
  def total_scores
    @games_data.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }
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

  ##== GAME HELPERS ==##

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

end
