module Helper
  def total_goals(game)
    game.away_goals + game.home_goals
  end

  def total_games(games)
    games.count
  end

  def total_teams(teams)
    teams.count
  end

  def average_away_goals(input_games)
    sum_away_goals = input_games.sum(&:away_goals)
    sum_away_goals.fdiv(input_games.count)
  end

  def average_home_goals(input_games)
    sum_home_goals = input_games.sum(&:home_goals)
    sum_home_goals.fdiv(input_games.count)
  end

  def average_of_goals(input_games)
    sum_goals = input_games.sum(&:goals)
    sum_goals.fdiv(input_games.count)
  end

  def average_accuracy(input_games)
    sum_shots = input_games.sum(&:shots)
    sum_goals = input_games.sum(&:goals)
    sum_goals.fdiv(sum_shots)*100
  end
end