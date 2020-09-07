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

  def result_counts_by_team_id(team_id)
    results_hash = {}
    results_hash[:total] = game_stats_by_team_id(team_id).length
    results_hash[:wins] = game_stats_by_team_id(team_id).select do |game|
      game.result == "WIN"
    end.length
    # maybe instead:
    # results_hash[:wins] = game_stats_by_team_id(team_id).map(&:result).count("WIN")
    results_hash[:ties] = game_stats_by_team_id(team_id).select do |game|
      game.result == "TIE"
    end.length
    results_hash[:losses] = game_stats_by_team_id(team_id).select do |game|
      game.result == "LOSS"
    end.length

    results_hash
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

  def best_season(team_id)
    all_results = game_stats_by_team_id(team_id)
    results_by_season = {}
    separate_games_by_season_id(games_by_team_id(team_id)).each do |season, games|
      results_by_season[season] = []
      games.each do |game|
        results_by_season[season] << all_results.find do |game_data|
          game.game_id == game_data.game_id
        end
      end
    end
    totals_by_season = {}
    results_by_season.each do |season, games|
      totals_by_season[season] = {}
      totals_by_season[season][:total] = games.length
      totals_by_season[season][:wins] = games.select do |game|
        game.result == "WIN"
      end.length
      totals_by_season[season][:average] = (totals_by_season[season][:wins].to_f / totals_by_season[season][:total].to_f).round(2)
    end

    totals_by_season.keys.max_by do |season|
      totals_by_season[season][:average]
    end
  end
end
