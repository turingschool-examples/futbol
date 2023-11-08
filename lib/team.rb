class Team
    attr_reader :team_id, :team_name

    def initialize(team_id, team_name)
      @team_id = team_id
      @team_name = team_name
    end
    
end