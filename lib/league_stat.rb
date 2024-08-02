module LeagueStatistics
    def count_of_teams
        @teams.count.to_i
       
    end

    def best_offense
        total_games = total_games_by_team
        total_goals = total_goals_by_team
        team_ids = total_goals.keys
        goals_per_game = Hash.new(0)
        team_ids.each do |team_id|
            goals_per_game[team_id] = total_goals[team_id] / total_games[team_id]
        end
        best_team = goals_per_game.max_by do |team_id, gpg| 
            gpg
        end
        get_team_name(best_team[0])
    end

    def worst_offense
        total_games = total_games_by_team
        total_goals = total_goals_by_team
        team_ids = total_goals.keys
        goals_per_game = Hash.new(0)
        team_ids.each do |team_id|
            goals_per_game[team_id] = total_goals[team_id] / total_games[team_id]
        end
        worst_team = goals_per_game.min_by do |team_id, gpg| 
            gpg
        end
        get_team_name(worst_team[0])
    end

    def total_goals_by_team
        total_goals = Hash.new(0)
        @game_teams.each do |game_team|
            total_goals[game_team.team_id] += (game_team.goals)
        end
        total_goals
    end

    def total_games_by_team
        total_games = Hash.new(0)
        @game_teams.each do |game_team|
            total_games[game_team.team_id] += 1
        end
        total_games
    end

    def highest_scoring_visitor
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
        highest_scoring_team = visitor_goals.max_by { |team_id, avg_goals| avg_goals }
        highest_scoring_team_id = highest_scoring_team[0]
        visitor_team_name = ''
        @teams.each do |team|
            visitor_team_name = team.team_name if team.team_id == highest_scoring_team_id
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