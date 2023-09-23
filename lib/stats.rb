class Stats
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
    @percentage_results = nil
    @teams_hash = nil
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

      @percentage_results[:home_wins] = (home_wins.to_f / number_games).round(2)

      away_wins = @games_data.count { |game| game[:away_goals].to_i > game[:home_goals].to_i }

      @percentage_results[:away_wins] = (away_wins.to_f / number_games).round(2)

      ties = @games_data.count { |game| game[:away_goals].to_i == game[:home_goals].to_i }

      @percentage_results[:ties] = (ties.to_f / number_games).round(2)
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

  ## SEASONAL SUMMARY AND HELPERS ##
  def seasonal_summaries
    # seasonal summary {team_id: {season: {reg season: , post season: {win percentage: float, total_goals_scored: int, total_goals_against: int, avg goals scored: float, avg goals against: float}} } }
    seasonal_summaries = Hash.new { |hash, key| hash[key] = {} }
    season_ids = @games_data.map { |game| game[:season] }.uniq

    @teams_data.each do |team|
      team_id = team[:team_id]
      seasonal_summaries[team_id] = {}
      season_ids.each do |season_id|
        regular_season_stats = season_stats("Regular Season", season_id, team_id)
        postseason_stats = season_stats("Postseason", season_id, team_id)

        seasonal_summaries[team_id][season_id] = {regular_season: regular_season_stats,
          postseason: postseason_stats}
      end
    end

    seasonal_summaries
  end

  ##== SEASON SUMMARY HELPERS ==##

  def season_stats(season_type, season_id, team_id)
    season_stats = Hash.new({})

    season_stats[:win_percentage] = win_percentage(season_type, season_id, team_id)
    season_stats[:total_goals_scored] = total_goals_scored(season_type, season_id, team_id)
    season_stats[:total_goals_against] = total_goals_against(season_type, season_id, team_id)
    season_stats[:average_goals_scored] = average_goals_scored(season_type, season_id, team_id)
    season_stats[:average_goals_against] = average_goals_against(season_type, season_id, team_id)

    season_stats
  end

  # @return: win percentage as a float for a given team in a given season
  def win_percentage(season_type, season_id, team_id)
    winning_game_count = 0
    game_count = 0

    @games_data.each do |game|
      if game[:type] == season_type && game[:season] == season_id
        if game[:away_team_id] == team_id || game[:home_team_id] == team_id
          game_count += 1
          if game[:away_team_id] == team_id && game[:away_goals].to_i > game[:home_goals].to_i ||
              game[:home_team_id] == team_id && game[:home_goals].to_i > game[:away_goals].to_i

            winning_game_count += 1
          end
        end
      end
    end

    ((winning_game_count.to_f / game_count)).round(2)
  end

  # returns integer for total goals scored by a given team in a given season
  def total_goals_scored(season_type, season_id, team_id)
    total_goals_scored = 0

    @games_data.each do |game|
      if game[:type] == season_type && game[:season] == season_id
        if game[:away_team_id] == team_id
          total_goals_scored += game[:away_goals].to_i
        elsif game[:home_team_id] == team_id
          total_goals_scored += game[:home_goals].to_i
        end
      end
    end
    total_goals_scored
  end

  # returns integer for total goals scored AGAINST a given team in a given season
  def total_goals_against(season_type, season_id, team_id)
    total_goals_against = 0

    @games_data.each do |game|
      if game[:type] == season_type && game[:season] == season_id
        if game[:away_team_id] == team_id
          total_goals_against += game[:home_goals].to_i
        elsif game[:home_team_id] == team_id
          total_goals_against += game[:away_goals].to_i
        end
      end
    end

    total_goals_against
  end

  # returns a float for average goals scored by a given team in a given season
  def average_goals_scored(season_type, season_id, team_id)
    total_scored = total_goals_scored(season_type, season_id, team_id)
    total_games = @games_data.count { |game|
      game[:type] == season_type && game[:season] == season_id && \
        [game[:away_team_id], game[:home_team_id]].include?(team_id)
    }

    (total_scored.to_f / total_games.to_f).round(2)
  end

  # returns a float for average goals scored AGAINST a given team in a given season
  def average_goals_against(season_type, season_id, team_id)
    total_scored = total_goals_against(season_type, season_id, team_id)
    total_games = @games_data.count { |game|
      game[:type] == season_type && game[:season] == season_id && \
        [game[:away_team_id], game[:home_team_id]].include?(team_id)
    }

    (total_scored.to_f / total_games.to_f).round(2)
  end

  ##== SEASON SUMMARY HELPERS ==##

  ##== TEAM HELPERS ==##

  # @return: { team_id: {sub queries} }
  def teams_hash
    if @teams_hash.nil?
      @teams_hash = {}
      
      @teams_hash[:max_min_goals] = max_min_goals
      @teams_hash[:teams_info] = teams_info
      @teams_hash[:percent_wins] = percent_wins
      @teams_hash[:average_wins] = average_wins
      @teams_hash[:team_goals] = nil
      @teams_hash[:win_pct_opp] = win_pct_opp
      @teams_hash[:goal_diffs] = goal_diffs  # {team_id: [goal_diffs]}
      @teams_hash[:seasonal_summaries] = seasonal_summaries
    end

    @teams_hash
  end

  def teams_info
    team_info_hash = Hash.new { |hash, key| hash[key] = {} } # {:team_id, CSV::Row from teams_data}

    @teams_data.each do |team|
      team_info_hash[team[:team_id]] = {
        "team_id" => team[:team_id],
        "franchise_id" => team[:franchiseid],
        "team_name" => team[:teamname],
        "abbreviation" => team[:abbreviation],
        "link" => team[:link]
      }
    end

    team_info_hash
  end

  def percent_wins
    # {team_id: {season: win percentage}}
    percent_wins = Hash.new { |hash, key| hash[key] = {} }
    season_ids = @games_data.map { |game| game[:season] }.uniq

    @teams_data.each do |team|
      team_id = team[:team_id]
      percent_wins[team_id] = {}

      season_ids.each do |season_id|
        winning_game_count = 0
        game_count = 0

        @games_data.each do |game|
          if season_id == game[:season]
            if team_id == game[:home_team_id] || team_id == game[:away_team_id]
              game_count += 1
              if game[:away_team_id] == team_id && game[:away_goals].to_i > game[:home_goals].to_i || \
                  game[:home_team_id] == team_id && game[:home_goals].to_i > game[:away_goals].to_i
                winning_game_count += 1
              end
            end
          end
        end

        percent_wins[team_id][season_id] = if game_count == 0
          0
        else
          ((winning_game_count.to_f / game_count) * 100.0).round(2)
        end
      end
    end

    percent_wins
  end

  def average_wins
    average_wins = Hash.new { |hash, key| hash[key] = {} }

    @teams_data.each do |team|
      team_id = team[:team_id]
      average_wins[team_id] = {}

      winning_game_count = 0
      game_count = 0

      @game_teams_data.each do |game|
        if team_id == game[:team_id]
          game_count += 1
          if game[:result] == "WIN"
            winning_game_count += 1
          end
        end
      end

      average_wins[team_id] = if game_count == 0
        0.0
      else
        ((winning_game_count.to_f / game_count)).round(2)
      end
    end

    average_wins
  end

  def win_pct_opp
    win_pct_opp = Hash.new { |hash, key| hash[key] = {} }  # {team_id: {head_to_head: {opp: win_pct},
    #                                                                   favorite_opponent: opp string,
    #                                                                   rival: opp string}}

    game_team_size = @game_teams_data.size
    @game_teams_data.each_with_index do |team_game, idx|
      # a team_game will have a :game_id match in another row; look in the index next or before
      # need to check that index in range or will hit NoMethodError when calling [:game_id] key
      opp = if idx + 1 < game_team_size && @game_teams_data[idx + 1][:game_id] == team_game[:game_id]
        @game_teams_data[idx + 1][:team_id]
      elsif idx - 1 > 0 && @game_teams_data[idx - 1][:game_id] == team_game[:game_id]
        @game_teams_data[idx - 1][:team_id]
      else
        next  # no game_id match was found, skip the iteration
      end

      win_pct_opp[team_game[:team_id]][:head_to_head] ||= {}
      win_pct_opp[team_game[:team_id]][:head_to_head][opp] ||= []
      win_pct_opp[team_game[:team_id]][:head_to_head][opp] << team_game[:result]
    end

    win_pct_opp.each do |team_id, win_data|
      win_data[:head_to_head].transform_values! do |results|  # => array of "WIN" || "LOSS"
        (results.count("WIN") / results.size.to_f).round(2)
      end

      fav_opp_id = win_data[:head_to_head].max_by { |_, pct| pct }[0]
      rival_id = win_data[:head_to_head].min_by { |_, pct| pct }[0]
      win_pct_opp[team_id][:favorite_opponent] = team_name_from_id(fav_opp_id)
      win_pct_opp[team_id][:rival] = team_name_from_id(rival_id)
    end

    win_pct_opp
  end

  # Each game record has home and away team_id, each iteration will add values to two keys
  # @return: array of all goal differentials
  def goal_diffs
    goal_diffs = Hash.new { |hash, key| hash[key] = [] }  # {team_id: [goal_diffs]}
    @games_data.each do |game|
      goal_diffs[game[:home_team_id]] << game[:home_goals].to_i - game[:away_goals].to_i
      goal_diffs[game[:away_team_id]] << game[:away_goals].to_i - game[:home_goals].to_i
    end

    goal_diffs
  end

  def max_min_goals
    team_highest_goals = Hash.new { |hash, key| hash[key] = 0 } # a hash of {team_id: [highest goals scored]}
    team_lowest_goals = Hash.new { |hash, key| hash[key] = Float::INFINITY } # a hash of {team_id: [lowest goals scored]}

    @game_teams_data.each do |game_team|
      team_id = game_team[:team_id]
      goals_scored = game_team[:goals].to_i

      if goals_scored > team_highest_goals[team_id]
        team_highest_goals[team_id] = goals_scored
      end

      if goals_scored < team_lowest_goals[team_id]
        team_lowest_goals[team_id] = goals_scored
      end
    end

    { highest_goals: team_highest_goals, lowest_goals: team_lowest_goals }
  end
  #== TEAM HELPERS ==##
end
