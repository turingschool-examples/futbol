class TeamsRepo
    def initialize(teams_path)
      @teams = make_teams(teams_path)
    end
   
    def make_teams(teams_path)
      teams = []
      CSV.foreach(teams_path, headers: true, header_converters: :symbol) do |row|
        teams << Teams.new(row)
      end
      teams
    end

    def team_info(arg_id)
        queried_team = Hash.new
        @teams.find do |team|
    
          if team.team_id == arg_id
            queried_team["team_id"] = team.team_id
            queried_team["franchise_id"] = team.franchiseid
            queried_team["team_name"] = team.teamname
            queried_team["abbreviation"] = team.abbreviation
            queried_team["link"] = team.link
          end
        end
    
        queried_team
      end
    
end
