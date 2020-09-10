module TeamStatistics
  def team_info(team_id)
    team = teams.find do |team|  # Could refactor loop as find_team(team_id)
      team.team_id == team_id
    end
    team_hash = Hash.new
    team_hash["team_id"] = team.team_id
    team_hash["franchise_id"] = team.franchise_id
    team_hash["team_name"] = team.team_name
    team_hash["abbreviation"] = team.abbreviation
    team_hash["link"] = team.link

    team_hash
  end

  def games_by_team_id(team_id, games_array = games)
    games_array.select do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end

  def games_to_game_ids(games_array)
    games_array.map do |game|
      game.game_id
    end
  end

  def separate_games_by_season_id(games_array = games)
    season_hash = {}
    games_array.each do |game|
      if season_hash[game.season] == nil
        season_hash[game.season] = [game]
      else
        season_hash[game.season] << game
      end
    end

    season_hash
  end

  def result_counts_by_team_id(team_id)  # Refactor to take game_ids as an arg
    results = {}
    results[:total] = game_stats_by_team_id(team_id).length
    results[:wins] = game_stats_by_team_id(team_id).select do |game|
      game.result == "WIN"
    end.length
    # maybe instead:
    # results[:wins] = game_stats_by_team_id(team_id).map(&:result).count("WIN")
    results[:ties] = game_stats_by_team_id(team_id).select do |game|
      game.result == "TIE"
    end.length
    results[:losses] = game_stats_by_team_id(team_id).select do |game|
      game.result == "LOSS"
    end.length

    results
  end

  def game_stats_by_team_id(team_id)
    game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def most_goals_scored(team_id)
    game_stats_by_team_id(team_id).max_by do |game|
      game.goals
    end.goals
  end

  def fewest_goals_scored(team_id)
    game_stats_by_team_id(team_id).min_by do |game|
      game.goals
    end.goals
  end

  def average_win_percentage(team_id)
    (result_counts_by_team_id(team_id)[:wins].to_f / result_counts_by_team_id(team_id)[:total].to_f).round(2)
  end

  def results_by_season(team_id)
    game_teams_array = game_stats_by_team_id(team_id)
    results_by_season = {}
    separate_games_by_season_id(games_by_team_id(team_id)).each do |season, games|
      results_by_season[season] = []
      games.each do |game|
        results_by_season[season] << game_teams_array.find do |game_data|
          game.game_id == game_data.game_id
        end
      end
    end

    results_by_season
  end

  def season_totals(game_teams_by_season)
    totals_by_season = {}
    game_teams_by_season.each do |season, games|
      totals_by_season[season] = {}
      totals_by_season[season][:total] = games.length
      totals_by_season[season][:wins] = games.select do |game|
        game.result == "WIN"
      end.length
      totals_by_season[season][:average] = (totals_by_season[season][:wins].to_f / totals_by_season[season][:total].to_f).round(2)
    end

    totals_by_season
  end

  def best_season(team_id)
    totals = season_totals(results_by_season(team_id))
    totals.keys.max_by do |season|
      totals[season][:average]
    end
  end

  def worst_season(team_id)
    totals = season_totals(results_by_season(team_id))
    totals.keys.min_by do |season|
      totals[season][:average]
    end
  end

  def favorite_opponent(team_id)
    game_ids = games_to_game_ids(games_by_team_id(team_id))
    opponent_games = {}
    teams.each do |team|
      if (team.team_id != team_id)
        opponent_games[team.team_id] = {}
        opponent_games[team.team_id][:game_data] = game_teams.select do |single_game_stats|
          ((single_game_stats.team_id == team.team_id) && (game_ids.include?(single_game_stats.game_id)))
        end
      end
    end

    opponent_games.each do |team_id, team_data|
      opponent_games[team_id][:total] = team_data[:game_data].length
      opponent_games[team_id][:wins] = team_data[:game_data].select do |game|
        game.result == "WIN"
      end.length
      opponent_games[team_id][:win_percent] = (opponent_games[team_id][:wins]/opponent_games[team_id][:total].to_f).round(2)
    end

    favorite_id = opponent_games.keys.min_by do |team_id|
      opponent_games[team_id][:win_percent]
    end

    team_info(favorite_id)["team_name"]
  end

  def rival(team_id)
    game_ids = games_to_game_ids(games_by_team_id(team_id))
    opponent_games = {}
    teams.each do |team|
      if (team.team_id != team_id)
        opponent_games[team.team_id] = {}
        opponent_games[team.team_id][:game_data] = game_teams.select do |single_game_stats|
          ((single_game_stats.team_id == team.team_id) && (game_ids.include?(single_game_stats.game_id)))
        end
      end
    end

    opponent_games.each do |team_id, team_data|
      opponent_games[team_id][:total] = team_data[:game_data].length
      opponent_games[team_id][:wins] = team_data[:game_data].select do |game|
        game.result == "WIN"
      end.length
      opponent_games[team_id][:win_percent] = (opponent_games[team_id][:wins]/opponent_games[team_id][:total].to_f).round(2)
    end

    rival_id = opponent_games.keys.max_by do |team_id|
      opponent_games[team_id][:win_percent]
    end

    team_info(rival_id)["team_name"]
  end
end
