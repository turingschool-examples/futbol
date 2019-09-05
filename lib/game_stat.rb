module GameStat

  def highest_total_score
    highest_game = all_games.max_by{ |game| game.home_goals + game.away_goals}
    highest_game.home_goals + highest_game.away_goals
  end

  def lowest_total_score
    lowest_game = all_games.min_by { |game| game.home_goals + game.away_goals }
    lowest_game.home_goals + lowest_game.away_goals
  end
end
