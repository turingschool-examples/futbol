module LeagueStatistics
    def count_of_teams
        @teams.count.to_i
    end

    def best_offense
        team_totals = team_goals_and_games(game_teams)
        team_goals_per_game = goals_per_game(team_totals)
        worst_team = team_goals_per_game.max_by {|team_id, gpg| gpg } 
        get_team_name(worst_team[0])
    end

    def worst_offense
        team_totals = team_goals_and_games(game_teams)
        team_goals_per_game = goals_per_game(team_totals)
        worst_team = team_goals_per_game.min_by {|team_id, gpg| gpg } 
        get_team_name(worst_team[0])
    end

    def highest_scoring_visitor
        get_team_name(home_away_goals_and_games("away", "highest"))
    end

    def highest_scoring_home_team
        get_team_name(home_away_goals_and_games("home", "highest"))
    end

    def lowest_scoring_visitor
        get_team_name(home_away_goals_and_games("away", "lowest"))
    end

    def lowest_scoring_home_team
        get_team_name(home_away_goals_and_games("home", "lowest"))
    end
 
    def home_away_goals_and_games(home_or_away, highest_or_lowest) 
        selected_games = @game_teams.select {|game| game.hoa == home_or_away}
        team_totals = team_goals_and_games(selected_games)
        team_goals = goals_per_game(team_totals)
        if highest_or_lowest == "highest"
            return (team_goals.max_by { |team_id, avg_goals| avg_goals })[0]
        elsif highest_or_lowest == "lowest"
            return (team_goals.min_by { |team_id, avg_goals| avg_goals })[0]
        end
    end

    def team_goals_and_games(selected_games)
        team_totals = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
        selected_games.each do |game|
            team_totals[game.team_id][:goals] += game.goals
            team_totals[game.team_id][:games] += 1
        end
        team_totals
    end

    def goals_per_game(team_totals)
        team_goals = {}
        team_totals.each do |team_id, data|
            team_goals[team_id] = data[:goals].to_f / data[:games]
        end
        team_goals
    end
end

    