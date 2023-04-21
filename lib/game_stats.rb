module GameStats
  
  def highest_total_score

  end

  def percentage_home_wins 
    home_wins = 0 
  end

  def average_goals_per_game
    goals = @games.sum(&:away_goals) + @games.sum(&:home_goals)
    goals.fdiv(@games.length).round(2)
  end
end