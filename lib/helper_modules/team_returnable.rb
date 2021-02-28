module ReturnTeamable
  #returns the team object with all of the data for the team.
  def return_team(team_id, team_data)
    team_data.find {|team| team.team_id == team_id}
  end
end
