class Team
    attr_reader :team_id,
                :franchise_id,
                :team_name,
                :abbreviation
                
    def initialize(teams_data)
        @team_id = teams_data[:team_id]
        @franchise_id = teams_data[:franchise_id]
        @team_name = teams_data[:team_name]
        @abbreviation = teams_data[:abbreviation]

    end
end