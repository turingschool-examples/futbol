require 'csv'

class Team
    attr_reader :team_data

    def initialize(team_data)
        @team_data = team_data
    end
end