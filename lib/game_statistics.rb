class GameStatistics

  def highest_total_score(game_data)
    total_goals_by_game(game_data).values.max
  end

  def lowest_total_score(game_data)
    total_goals_by_game(game_data).values.min
  end

  def total_goals_by_game(game_data)
    all_game_scores = {}
    game_data.each do |game_id, game|
      all_game_scores[game_id] = (game.away_goals + game.home_goals)
    end
    all_game_scores
  end

  def total_games(game_data)
    game_data.count
  end

  def total_home_wins(game_data)
    wins = 0
    game_data.each do |game_id, game|
      wins += 1 if (game.home_goals > game.away_goals)
    end
    wins
  end

  def percentage_home_wins(game_data)
    (total_home_wins(game_data) / total_games(game_data).to_f).round(2)
  end

  def total_away_wins(game_data)
    wins = 0
    game_data.each do |game_id, game|
      wins += 1 if (game.home_goals < game.away_goals)
    end
    wins
  end

  def percentage_visitor_wins(game_data)
    (total_away_wins(game_data) / total_games(game_data).to_f).round(2)
  end

  def total_ties(game_data)
    ties = 0
    game_data.each do |game_id, game|
      ties += 1 if (game.home_goals == game.away_goals)
    end
    ties
  end

  def percentage_ties(game_data)
    (total_ties(game_data) / total_games(game_data).to_f).round(2)
  end

  def count_of_games_by_season(game_data)
    seasons = season_keys(game_data).uniq
    games_by_season = {}
    seasons.each do |season|
      count = 0
      game_data.each do |game_id, game_obj|
        count += 1 if season == game_obj.season
      end
        games_by_season[season] = count
    end
    games_by_season
  end

  def season_keys(game_data)
    game_data.map do |game_id, game_obj|
      game_obj.season
    end
  end

  def average_goals_per_game(game_data)
    (total_goals_by_game(game_data).values.sum / total_goals_by_game(game_data).count.to_f).round(2)
  end

  def average_goals_by_season(game_data)
    average_goals = {}
    season_game_count = count_of_games_by_season(game_data)
    game_data.each do |game_id, game_obj|
      if average_goals[game_obj.season].nil?
        average_goals[game_obj.season] = (game_obj.home_goals + game_obj.away_goals)
      else
        average_goals[game_obj.season] += (game_obj.home_goals + game_obj.away_goals)
      end
    end
    average_goals.each do |season, goals|
      average_goals[season] = (goals.to_f / season_game_count[season]).round(2)
    end
    average_goals
  end
end
