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
    (sum_goals.fdiv(sum_shots)*100).round(2)
  end

  def percent_win_loss(input_games)
    count_wins = input_games.count {|game_team| game_team.result == "WIN"}
    count_ties = input_games.count {|game_team| game_team.result == "TIE"}
    count_wins.fdiv(input_games.length)
  end

  def get_wins(id)
    @games.select {|game| away_win?(game, id) || home_win?(game, id)}
  end

  def get_losses(id)
    @games.select{|game| away_loss?(game, id) || home_loss?(game, id)}
  end

  def away_win?(game, id)
    game.away_team_id == id && game.away_goals > game.home_goals
  end

  def home_win?(game, id)
    game.home_team_id == id && game.home_goals > game.away_goals
  end

  def away_loss?(game, id)
    game.away_team_id == id && game.away_goals < game.home_goals
  end

  def home_loss?(game, id)
    game.home_team_id == id && game.home_goals < game.away_goals
  end
end