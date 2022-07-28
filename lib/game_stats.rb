module GameStats

  def average_goals_per_game
    total_goals = @games.sum{ |game| game.total_goals }
    (total_goals.to_f / @games.length).round(2)
  end
  
end
