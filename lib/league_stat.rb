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
        @teams.each do |team|
            return team.team_name if team.team_id == team_goals_and_games("away", "highest")
        end
    end

    def highest_scoring_home_team
        @teams.each do |team|
            return team.team_name if team.team_id == team_goals_and_games("home", "highest")
        end
    end

    def lowest_scoring_visitor
        @teams.each do |team|
            return team.team_name if team.team_id == team_goals_and_games("away", "lowest")
        end
    end

    def lowest_scoring_home_team
        @teams.each do |team|
            return team.team_name if team.team_id == team_goals_and_games("home", "lowest")
        end
    end

    private 
    def team_goals_and_games(home_or_away, highest_or_lowest) 
        team_totals = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
        selected_games = @game_teams.select {|game| game.hoa == home_or_away}
        selected_games.each do |game|
            team_totals[game.team_id][:goals] += game.goals
            team_totals[game.team_id][:games] += 1
        end
        team_goals = {}
        team_totals.each do |team_id, data|
        team_goals[team_id] = data[:goals].to_f / data[:games]
        end
        if highest_or_lowest == "highest"
            return (team_goals.max_by { |team_id, avg_goals| avg_goals })[0]
        elsif highest_or_lowest == "lowest"
            return (team_goals.min_by { |team_id, avg_goals| avg_goals })[0]
        end
    end
end

    