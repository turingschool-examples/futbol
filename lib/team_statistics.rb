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
        if (team_id.to_i) == game.away_team_id && (game.away_goals < game.home_goals || game.away_goals == game.home_goals)
          losses += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals > game.home_goals || game.away_goals == game.home_goals)
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

  def most_goals_scored(team_id)
    most_goals = 0
    collect_seasons(team_id).each do |key, value|
      value.each do |game|
        if team_id.to_i == game.away_team_id
          most_goals = game.away_goals if game.away_goals > most_goals
        elsif team_id.to_i == game.home_team_id
          most_goals = game.home_goals if game.home_goals > most_goals
        end
      end
    end
    most_goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = 5
    collect_seasons(team_id).each do |key, value|
      value.each do |game|
        if team_id.to_i == game.away_team_id
          fewest_goals = game.away_goals if game.away_goals < fewest_goals
        elsif team_id.to_i == game.home_team_id
          fewest_goals = game.home_goals if game.home_goals < fewest_goals
        end
      end
    end
    fewest_goals
  end

  def games_for_team_id(team_id)
    games = []
      @game_table.each do |game_id, game_info|
        if game_info.away_team_id == team_id.to_i || game_info.home_team_id == team_id.to_i
          games << game_info.game_id
        end
      end
    @game_team_table.find_all do |game|
      games.include?(game.game_id)
    end
  end

  def favorite_opponent(team_id)
    games = games_for_team_id(team_id)
    opponents = {}
    game_count = {}
    games.each do |game|
      if team_id.to_i != game.team_id && opponents[game.team_id].nil?
        game_count[game.team_id] = 1
        if game.result == "WIN"
          opponents[game.team_id] = 1
        else
          opponents[game.team_id] = 0
        end
      elsif team_id.to_i != game.team_id
        opponents[game.team_id] += 1 if game.result == "WIN"
        game_count[game.team_id] += 1
      end
    end
    win_percentages = {}
    opponents.each do |team, wins|
      win_percentages[team] = wins / game_count[team].to_f
    end
    require "pry"; binding.pry
    favorite_team_id = win_percentages.key(win_percentages.values.min)
    favorite_team = @team_table.find do |team_id, info|
      team_id.to_i == favorite_team_id
    end
    favorite_team[1].team_name
  end

end
