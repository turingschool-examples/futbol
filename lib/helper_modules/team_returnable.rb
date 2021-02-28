module ReturnTeamable
  def return_team_name(team_id, team_data)
    team_data.find {|team| team.team_id == team_id}.teamname
  end
end