module ReturnTeamable
  def return_team_name(team_id, team_data)
    team_data.find {|team| team_id = team.team_id }.teamname
  end
end