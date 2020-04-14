module Calculable

  def average(numerator, denominator)
    (numerator.to_f/denominator).round(2)
  end

  def calculate_win_percentage(team_games)
    wins = 0.0
    team_games.each {|game| wins += 1.0 if game.result == "WIN"}
    (wins / team_games.length)
  end
end
