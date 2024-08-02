module LeagueStatistics
    def count_of_teams
        @teams.count.to_i
    end

    def best_offense
        @goals.max.to_s
    end

    def worst_offense

    end

  # highest_scoring_visitor	Name of the team with the highest average score per 
        # game across all seasons when they are away.	String
    def highest_scoring_visitor
        #iterate through games.csv create a hash key == away team.id, value is away goals
       hash = {}
       @games.each do |game|
            if hash.keys.include?(game.away_team_id) 
                hash[game.away_team_id] += game.away_goals
            else 
                hash[game.away_team_id] = game.away_goals
            end
       end
        
        #find team name in teams.csv that matches away team id with most goals
        away_team_name = String
        @teams.each do |team|
        away_team_name = team.team_name if team.team_id == hash.max[0]
        end
        #returns team name of highest scoring visitor as a string
        away_team_name
    end

    def highest_scoring_home_team
       
    end

    def lowest_scoring_visitor
       
     
    end

    def lowest_scoring_home_team
      
    end



end