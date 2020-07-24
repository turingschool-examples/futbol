class TeamStats < Stats


  def team_info(team_id)
    result = @teams.find do |team|
      team.team_id == team_id
    end
    {"team_id" => result.team_id,
    "franchise_id" => result.franchise_id,
    "team_name" => result.team_name,
    "abbreviation" => result.abbreviation,
    "link" => result.link}
  end
end
