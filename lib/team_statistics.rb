module TeamStatistics

  def team_info(team_id)
    team_info = {}
    team = @team_table.fetch(team_id)
    team.instance_variables.each do |instance_variable|
      team_info[instance_variable.to_s.delete(":@")] = team.instance_variable_get(instance_variable)
    end
    team_info.delete("stadium")
    team_info
  end

  def collect_seasons(team_id)
    season_game_id_hash = {}
      @game_table.each do |game_id, game|
        if  season_game_id_hash[game.season].nil? && (team_id.to_i == game.away_team_id || team_id.to_i == game.home_team_id)
           season_game_id_hash[game.season] = [game]
         elsif (team_id.to_i == game.away_team_id) || (team_id.to_i == game.home_team_id)
           season_game_id_hash[game.season] << game
         end
      end
    season_game_id_hash
  end

  def collect_wins_per_season(team_id)
    season_wins = {}
    collect_seasons(team_id).each do |season, info|
      wins = 0
      info.each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals > game.home_goals)
          wins += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals < game.home_goals)
          wins += 1
        end
      end
      season_wins[season] = wins
    end
    season_wins
  end

  def best_season(team_id)
    season_games = collect_seasons(team_id)
    season_wins_hash = collect_wins_per_season(team_id)
    winning_percentage_per_season = {}
    season_wins_hash.each do |season, wins|
      winning_percentage_per_season[season] = (wins.to_f/season_games.length).round(2)
    end
    winning_percentage_per_season.key(winning_percentage_per_season.values.max)
  end

  def collect_losses_per_season(team_id)
    season_losses = {}
    collect_seasons(team_id).each do |season, info|
      losses = 0
      info.each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals < game.home_goals)
          losses += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals > game.home_goals)
          losses += 1
        end
      end
      season_losses[season] = losses
    end
    season_losses
  end

  def worst_season(team_id)
    season_games = collect_seasons(team_id)
    season_losses_hash = collect_losses_per_season(team_id)
    losing_percentage_per_season = {}
    season_losses_hash.each do |season, losses|
      losing_percentage_per_season[season] = (losses.to_f/season_games[season].length).round(2)
    end
    losing_percentage_per_season.key(losing_percentage_per_season.values.max)
  end

  def average_win_percentage(team_id)
    total_average_win_percentage = 0
    total_games = 0
    collect_seasons(team_id).each do |key, value|
      total_games += value.length
    end
    collect_wins_per_season(team_id).each do |key, value|
      total_average_win_percentage += value
    end
    (total_average_win_percentage.to_f/total_games).round(2)
  end
end
