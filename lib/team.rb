require_relative 'array_generator'

class Team
    attr_reader :team_id,
                :franchise_id,
                :team_name,
                :abbreviation,
                :stadium,
                :link

    def initialize(info)
        @team_id = info[:team_id]
        @franchise_id = info[:franchiseID]
        @team_name = info[:teamName]
        @abbreviation = info[:abbreviation]
        @stadium = info[:Stadium]
        @link = info[:link]
    end
end
