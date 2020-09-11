module TeamStatistics
  def team_info(team_id)
    team = teams.find do |team_obj|
      team_obj.team_id == team_id
    end
    team_hash = {}
    team_hash['team_id'] = team.team_id
    team_hash['franchise_id'] = team.franchise_id
    team_hash['team_name'] = team.team_name
    team_hash['abbreviation'] = team.abbreviation
    team_hash['link'] = team.link

    team_hash
  end

  def games_by_team_id(team_id, games_array = games)
    games_array.select do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end

  def games_to_game_ids(games_array)
    games_array.map(&:game_id)
  end

  def separate_games_by_season_id(games_array = games)
    games_array.reduce({}) do |seasons, game|
      seasons[game.season] = [] if seasons[game.season].nil?
      seasons[game.season] << game
      seasons
    end
  end

  def result_counts_by_team_id(team_id)  # Refactor to take game_ids as an arg
    results = {}
    results[:total] = game_stats_by_team_id(team_id).length
    results[:wins] = game_stats_by_team_id(team_id).select do |game|
      game.result == 'WIN'
    end.length
    results[:ties] = game_stats_by_team_id(team_id).select do |game|
      game.result == 'TIE'
    end.length
    results[:losses] = game_stats_by_team_id(team_id).select do |game|
      game.result == 'LOSS'
    end.length

    results
  end

  def game_stats_by_team_id(team_id)
    game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def most_goals_scored(team_id)
    game_stats_by_team_id(team_id).max_by(&:goals).goals
  end

  def fewest_goals_scored(team_id)
    game_stats_by_team_id(team_id).min_by(&:goals).goals
  end

  def average_win_percentage(team_id)
    (result_counts_by_team_id(team_id)[:wins] / result_counts_by_team_id(team_id)[:total].to_f).round(2)
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
    totals = {}
    game_teams_by_season.each do |season, games|
      totals[season] = {}
      totals[season][:total] = games.length
      totals[season][:wins] = games.select do |game|
        game.result == 'WIN'
      end.length
      totals[season][:average] = (totals[season][:wins] / totals[season][:total].to_f).round(2)
    end

    totals
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

  def opponent_game_teams(team_id)
    game_ids = games_to_game_ids(games_by_team_id(team_id))
    opponent_ids = teams.reject do |team|
      team.team_id == team_id
    end.map(&:team_id)
    opponent_ids.reduce({}) do |collector, id|
      collector[id] = {}
      collector[id][:game_data] = game_teams.select do |game_team|
        game_ids.include?(game_team.game_id) && game_team.team_id == id
      end
      collector
    end
  end

  def opponent_win_stats(team_id)
    game_teams_hash = opponent_game_teams(team_id)
    game_teams_hash.each do |id, data|
      game_teams_hash[id][:total] = data[:game_data].length
      game_teams_hash[id][:wins] = data[:game_data].select do |game|
        game.result == 'WIN'
      end.length
      game_teams_hash[id][:win_percent] = (game_teams_hash[id][:wins] / game_teams_hash[id][:total].to_f).round(2)
    end

    game_teams_hash
  end

  def favorite_opponent(team_id)
    favorite_id = opponent_win_stats(team_id).min_by do |id, data|
      data[:win_percent]
    end.first

    team_info(favorite_id)['team_name']
  end

  def rival(team_id)
    rival_id = opponent_win_stats(team_id).max_by do |id, data|
      data[:win_percent]
    end.first

    team_info(rival_id)['team_name']
  end
end
