module Helper
  def convert_to_team_name(input_team_id)
    team = @teams.find {|team| team.team_id == input_team_id}
    team.team_name
  end

  def average_away_goals(input_games)
    sum_away_goals = input_games.sum(&:away_goals)
    sum_away_goals.to_f/input_games.length.to_f
  end
end