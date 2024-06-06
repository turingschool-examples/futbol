class Team 
    attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :Stadium, :link
    #readable instance variables

    def initialize(data)
        @team_id = data[:team_id]
        @franchiseId = data[:franchiseId]
        @teamName = data[:teamName]
        @abbreviation = data[:abbreviation]
        @Stadium = data[:Stadium]
        @link = data[:link]
        #instance variables here
    end
end