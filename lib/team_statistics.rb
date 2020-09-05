module TeamStatistics
  def team_info(team_id)
    team = @teams.find do |team|  # Could refactor loop as find_team(team_id)
      team.team_id == team_id
    end

    team_hash = Hash.new
    team_hash[:team_id] = team.team_id
    team_hash[:franchise_id] = team.franchise_id
    team_hash[:team_name] = team.team_name
    team_hash[:abbreviation] = team.abbreviation
    team_hash[:stadium] = team.stadium
    team_hash[:link] = team.link

    team_hash
  end
end
