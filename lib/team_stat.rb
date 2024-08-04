module TeamStatistics
    def team_info(team_id)
        display = Hash.new(0)
        info = teams.find {|team| team.team_id == team_id}
        display["team_name"] = info.team_name
        display["team_id"] = info.team_id
        display["franchise_id"] = info.franchise_id
        display["abbreviation"] = info.abbreviation
        display["link"] = info.link
        display
    end

end