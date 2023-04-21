module GameStats

  def percentage_home_wins 
    home_wins = 0
    @games.each do |game| 
      home_wins += 1 if game.home_goals > game.away_goals
    end 
    percent = (home_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins 
    away_wins = 0 
    @games.each do |game| 
      away_wins += 1 if game.away_goals > game.home_goals
    end 
    percent = (away_wins.to_f / @games.count.to_f).round(2)
  end

  def average_goals_per_game
    goals = @games.sum(&:away_goals) + @games.sum(&:home_goals)
    goals.fdiv(@games.length).round(2)
  end
end