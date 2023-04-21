module GameStats
  
  def highest_total_score
    games.map { |game| game.home_goals + game.away_goals }.max
  end

  def lowest_total_score
    games.map { |game| game.away_goals + game.home_goals }.min
  end

  def percentage_home_wins 
    home_wins = 0 
  end

  def average_goals_per_game
    goals = @games.sum(&:away_goals) + @games.sum(&:home_goals)
    goals.fdiv(@games.length).round(2)
  end
end