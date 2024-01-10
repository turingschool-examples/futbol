class Teams
    attr_reader :team_name,
                :team_id

    def initialize(team_name, franchise_id, team_name, abbreviation, stadium, link)
        @team_name = team_name
        @franchise_id = franchise_id
        @team_name = team_name
        @abbreviation = abbreviation
        @stadium = stadium
        @link = link
    end

    # need to determine how we will get array to StatTracker class
    def create_teams(file_path)
        teams_array = []
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            team_name = row[:teamname]
            franchise_id = row [:franchiseid]
            team_name = row[:teamname]
            abbreviation = row[:abbreviation]
            stadium = row[:stadium]
            link = row[:link]
            teams_instance = Teams.new(team_name, franchise_id, team_name, abbreviation, stadium, link)
            teams_array << teams_instance
        end
        teams_array
    end
end