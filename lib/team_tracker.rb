class TeamTracker < Statistics

  # USE THIS METHOD TEAM INFO
  def team_info(team_id)
    team_hash = {}
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      team_hash[variable.to_sym] = team.instance_variable_get("@#{variable}".to_sym)
    end
    team_hash
  end


end
#tracker = TeamTracker.new
#p tracker.teams
#p tracker.team_info(tracker.teams[1])
