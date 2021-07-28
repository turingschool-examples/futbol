require 'csv'

module GamesProcessor
  def parse_games_file(file_path)
    games = []

    CSV.foreach(file_path, headers: true) do |row|
      games << {
        game_id: row["game_id"],
        season: row["season"],
        away_team_id: row["away_team_id"],
        home_team_id: row["home_team_id"],
        away_goals: row["away_goals"],
        home_goals: row["home_goals"]
      }
    end
    games
  end

  def best_season(team_id)
    season_avg = seasons_win_count(team_id)
    season_avg.each.max_by do |season, stats|
      stats[:wins].fdiv(stats[:total])
    end.first
  end

  def worst_season(team_id)
    season_avg = seasons_win_count(team_id)
    season_avg.each.min_by do |season, stats|
      stats[:wins].fdiv(stats[:total])
    end.first
  end

  def seasons_win_count(team_id)
    season_avg = {}

    @games.each do |game|
      season = game[:season]
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        season_avg[season] ||= {wins: 0, total: 0}
        teams = [game[:home_team_id], game[:away_team_id]]
        goals = [game[:home_goals], game[:away_goals]]
        team_index = teams.index(team_id)
        opp_index = team_index - 1

        if goals[team_index] > goals[opp_index]
        season_avg[season][:wins] += 1
        end
        season_avg[season][:total] += 1
      end
    end
    season_avg
  end

  def opponent_win_count(team_id)
    win_loss = {}
    @games.each do |game|
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        teams = [game[:home_team_id], game[:away_team_id]]
        goals = [game[:home_goals], game[:away_goals]]
        team_index = teams.index(team_id)
        opp_index = team_index - 1

        win_loss[teams[opp_index]] ||= {wins: 0, total: 0}
        if goals[team_index] > goals[opp_index]
          win_loss[teams[opp_index]][:wins] += 1
        end
        win_loss[teams[opp_index]][:total] += 1
      end
    end
    win_loss
  end

  def average_win_percentage(team_id)
    wins = 0
    games = 0
    seasons_win_count(team_id).each do |season, stats|
      wins += stats[:wins]
      games += stats[:total]
    end
    (wins.fdiv(games)).round(2)
  end

  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.each.map do |team, results|
      avg = results[:wins].fdiv(results[:total])
      [team, avg]
    end.to_h
  end

  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    fav_team = win_loss.each.max_by do |team, result|
      result
    end.first

    team_info(fav_team)["team_name"]
  end

  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.each.min_by do |team, result|
      result
    end.first

    team_info(rival_team)["team_name"]
  end

  def highest_total_score
    highest_game = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_game[:away_goals].to_i + highest_game[:home_goals].to_i
  end

  def lowest_total_score
    lowest_game = @games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest_game[:away_goals].to_i + lowest_game[:home_goals].to_i
  end

  def percentage_home_wins
    home_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] > game[:away_goals]
        home_game_wins += 1
      end
    end
    (home_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_visitor_wins
    visitor_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] < game[:away_goals]
        visitor_game_wins += 1
      end
    end
    (visitor_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_ties
    ties = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] == game[:away_goals]
        ties += 1
      end
    end
    (ties.fdiv(total_games)).round(2)
  end

  def average_goals_by_season
    goals_per_season.reduce({}) do |acc, season_goals|
      acc[season_goals[0]] = season_goals[1].fdiv(games_per_season(season_goals[0])).round(2)
      acc
    end
  end

  def goals_per_game(game)
    game[:away_goals].to_i + game[:home_goals].to_i
  end

  def goals_per_season
    goals = {}
    @games.each do |game|
      goals[game[:season]] ||= 0
      goals[game[:season]] += goals_per_game(game)
    end
    goals
  end

  def games_per_season(season)
    @games.count do |game|
      game if game[:season] == season
    end
  end

  def count_of_games_by_season
    count_seasons = Hash.new(0)
    @games.each do |game|
      season = game[:season]
      count_seasons[season] += 1
    end
    count_seasons
  end

  def get_away_team_goals
    away_avg = {}
    @games.each do |game|
      away_avg[game[:away_team_id]] ||= { goals: 0, total: 0 }
      away_avg[game[:away_team_id]][:goals] += game[:away_goals].to_i
      away_avg[game[:away_team_id]][:total] += 1
    end
    away_avg
  end

  def highest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def lowest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def get_home_team_goals
    home_avg = {}
    @games.each do |game|
      home_avg[game[:home_team_id]] ||= { goals: 0, total: 0 }
      home_avg[game[:home_team_id]][:goals] += game[:home_goals].to_i
      home_avg[game[:home_team_id]][:total] += 1
    end
    home_avg
  end

  def highest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def lowest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

end
