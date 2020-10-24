class GameStatistics

  def highest_total_score(game_data)
    total_goals_by_game(game_data).values.max
  end

  def total_goals_by_game(game_data)
    all_game_scores = {}
    game_data.each do |game_id, game|
      all_game_scores[game_id] = (game.away_goals + game.home_goals)
    end
    all_game_scores
  end

end
