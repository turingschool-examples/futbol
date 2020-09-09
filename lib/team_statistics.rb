module TeamStatistics

  def team_info(team_id)
    team_info = {}
    team = @team_table.fetch(team_id)
    team.instance_variables.each do |instance_variable|
      team_info[instance_variable.to_s.delete(":@")] = team.instance_variable_get(instance_variable)
    end
    team_info.delete("stadium")
    team_info
  end


end
