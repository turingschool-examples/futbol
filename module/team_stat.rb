module TeamStat

  def team_info(team_id)
    team_info_hash = Hash.new
    team_info_hash["team_id"] = team_id
    team_info_hash["franchise_id"] = all_teams[team_id].franchise_id
    team_info_hash["team_name"] = all_teams[team_id].team_name
    team_info_hash["abbreviation"] = all_teams[team_id].abbreviation
    team_info_hash["link"] = all_teams[team_id].link
    team_info_hash
  end
end
