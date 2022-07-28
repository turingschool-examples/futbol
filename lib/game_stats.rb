module GameStats

  def lowest_total_score
    @games.map {|game| game.total_goals}.min
  end

  def highest_total_score
    @games.map {|game| game.total_goals}.max
  end

  def average_goals_per_game
    total_goals = @games.sum{ |game| game.total_goals }
    (total_goals.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @games.count{ |game| game.winner == :home_team }
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    total_away_wins = @games.count do |game|
      game.winner == :away_team
    end
    (total_away_wins/@games.length.to_f).round(2)
  end

  def percentage_ties
    total_tie_games = @games.count{ |game| game.winner == :tie }
    (total_tie_games.to_f / @games.length).round(2)
  end
end
