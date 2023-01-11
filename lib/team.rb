class Team
    attr_reader :team_id,
                :franchise_id,
                :team_name,
                :abbreviation,
                :stadium,
                :link

    def initialize(info)
        @team_id = info[:team_id]
        @franchise_id = info[:franchiseid]
        @team_name = info[:teamname]
        @abbreviation = info[:abbreviation]
        @stadium = info[:stadium]
        @link = info[:link]
    end

    def self.read_file(locations)
        teams = CSV.read(locations, headers: true, header_converters: :symbol)
        
        teams.map do |team|
            new(team)
        end
    end
end
