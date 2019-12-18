class Team
    attr_reader :team_id, :franchiseId, :teamName, :abbreviation,
                :stadium

    def initialize(team_info)
        @team_id = team_info[:team_id].to_i
        @franchiseId = team_info[:franchiseId].to_i
        @teamName = team_info[:teamName]
        @abbreviation = team_info[:abbreviation]
        @stadium = team_info[:stadium]
    end
end
