module LeagueStatistics
    def count_of_teams
        @teams.count.to_i
       
    end

    def best_offense
        @goals.max.to_s
    end

    def worst_offense

    end

    def highest_scoring_visitor
        @teams.each do |team|
            return team.team_name if team.team_id == team_goals_and_games("away", "highest")
        end
        visitor_team_name
    end

    def highest_scoring_home_team
    home_totals = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
    @game_teams.each do |game|
        if game.hoa == "home" 
        home_totals[game.team_id][:goals] += game.goals
        home_totals[game.team_id][:games] += 1
        end
    end
    home_goals = {}
    home_totals.each do |team_id, data|
    home_goals[team_id] = data[:goals].to_f / data[:games]
    end
    highest_scoring_team = home_goals.max_by { |team_id, avg_goals| avg_goals }
    highest_scoring_team_id = highest_scoring_team[0]
    home_team_name = ''
    @teams.each do |team|
        home_team_name = team.team_name if team.team_id == highest_scoring_team_id
    end
    home_team_name
    end

    def lowest_scoring_visitor
        visitor_totals = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
        @game_teams.each do |game|
          if game.hoa == "away" 
            visitor_totals[game.team_id][:goals] += game.goals
            visitor_totals[game.team_id][:games] += 1
          end
        end
        visitor_goals = {}
        visitor_totals.each do |team_id, data|
        visitor_goals[team_id] = data[:goals].to_f / data[:games]
        end
        highest_scoring_team = visitor_goals.min_by { |team_id, avg_goals| avg_goals }
        highest_scoring_team_id = highest_scoring_team[0]
        visitor_team_name = ''
        @teams.each do |team|
            visitor_team_name = team.team_name if team.team_id == highest_scoring_team_id
        end
        visitor_team_name
    end

    def lowest_scoring_home_team
        home_totals = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
        @game_teams.each do |game|
            if game.hoa == "home" 
            home_totals[game.team_id][:goals] += game.goals
            home_totals[game.team_id][:games] += 1
            end
        end
        home_goals = {}
        home_totals.each do |team_id, data|
        home_goals[team_id] = data[:goals].to_f / data[:games]
        end
        highest_scoring_team = home_goals.min_by { |team_id, avg_goals| avg_goals }
        highest_scoring_team_id = highest_scoring_team[0]
        home_team_name = ''
        @teams.each do |team|
            home_team_name = team.team_name if team.team_id == highest_scoring_team_id
        end
        home_team_name
    end
end