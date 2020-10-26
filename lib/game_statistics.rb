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
    all_home_wins = {}
    wins = 0
    game_data.each do |game_id, game|
      wins += 1 if (game.home_goals > game.away_goals)
    end
    wins
  end
end
