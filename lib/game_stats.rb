module GameStats

  def highest_total_score
    games.map { |game| game.home_goals + game.away_goals }.max
  end

  def lowest_total_score
    games.map { |game| game.away_goals + game.home_goals }.min
  end

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

  def percentage_ties
    ties = @games.select { |game| game.home_goals == game.away_goals }.size
    ties_percentage = ties.to_f / @games.size
    ties_percentage.round(2)
  end
  
  def count_of_games_by_season
    game_by_season = @games.map(&:season).tally
    game_by_season
  end

  def average_goals_per_game
    total_goals(@games).fdiv(@games.length).round(2)
  end

  def average_goals_by_season
   
  end

  def total_goals(games)
    games.sum(&:away_goals) + games.sum(&:home_goals)
  end
end