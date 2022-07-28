module GameStats

  def average_goals_per_game
    total_goals = @games.sum{ |game| game.total_goals }
    (total_goals.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @games.count{ |game| game.winner == :home_team }
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    total_tie_games = @games.count{ |game| game.winner == "TIE" }
    (total_tie_games.to_f / @games.length).round(2)
  end
end
