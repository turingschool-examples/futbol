module Helper
  def convert_to_team_name(input_team_id)
    team = @teams.find {|team| team.team_id == input_team_id}
    team.team_name
  end

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
    sum_away_goals.to_f/input_games.length.to_f
  end

  def average_home_goals(input_games)
    sum_home_goals = input_games.sum(&:home_goals)
    sum_home_goals.fdiv(input_games.count)
  end
end