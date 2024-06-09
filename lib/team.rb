class Team 
    attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :Stadium, :link
    #readable instance variables

    def initialize(data)
        @team_id = data[:team_id]
        @franchiseId = data[:franchiseid]
        @teamName = data[:teamname]
        @abbreviation = data[:abbreviation]
        @Stadium = data[:stadium]
        @link = data[:link]
       # require 'pry'; binding.pry  
    end
end