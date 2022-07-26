class TeamStatistics
    def initialize(statistics)
        @statistics = statistics
    end

    def team_info(team_id)
        # team_id, franchise_id, team_name, abbreviation, and link
        team_index = @statistics.teams[:team_id].index(team_id)
        team_info_return = (@statistics.teams[team_index].to_h).reject {|key, _value| key == :stadium}
    end
end