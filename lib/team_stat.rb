module TeamStatistics
    def team_info(team_id)
        display = Hash.new(0)
        info = teams.find {|team| team.team_id == team_id}
        display["team_name"] = info.team_name
        display["team_id"] = info.team_id
        display["franchise_id"] = info.franchise_id
        display["abbreviation"] = info.abbreviation
        display["link"] = info.link
        display
    end

    def best_season(team_id)
        hash = count_of_games_by_season_by_team(team_id)
        hash = find_ratio(hash)
        season = hash.max_by {|season, ratio| ratio}
        season[0]
    end

    def worst_season(team_id)
        hash = count_of_games_by_season_by_team(team_id)
        hash = find_ratio(hash)
        season = hash.min_by {|season, ratio| ratio}
        season[0]
    end

    def average_win_percentage(team_id)
        hash = count_of_games_by_season_by_team(team_id)
        hash = find_ratio(hash)
        sum = hash.sum {|_, value| value}
        (sum / hash.keys.count).round(2)
    end

    def fewest_goals_scored(team_id)
        goals = 0
        games.each do |game|
            if game.away_team_id == team_id 
                goals = game_check(game.away_goals, goals, 'low')    
            elsif game.home_team_id == team_id
                goals = game_check(game.home_goals, goals, 'low')
            end
        end
        goals
    end

    def most_goals_scored(team_id)
        goals = 0
        games.each do |game|
            if game.away_team_id == team_id 
                goals = game_check(game.away_goals, goals, 'high')    
            elsif game.home_team_id == team_id
                goals = game_check(game.home_goals, goals, 'high')
            end
        end
        goals
    end

    def favorite_opponent(team_id)
        favorite = team_by_team(team_id).max_by {|_,v| v}
        get_team_name(favorite[0])
    end

    def rival(team_id)
        rival = team_by_team(team_id).min_by {|_,v| v}
        get_team_name(rival[0])
    end
    
    def count_of_games_by_season_by_team(team_id)
        games_count = {}
        games.each do |game|
            if game.away_team_id == team_id || game.home_team_id == team_id
                games_count = update_seasons(game, games_count)
                games_count = update_team_games(game, games_count, team_id)
            end
        end
        games_count
    end

    def update_seasons(game_object, games_count)
        if games_count[game_object.season].nil?
            games_count[game_object.season] = [0, 0]
        end
        games_count
    end

    def update_team_games(game_object, game_count, team_id)
        if game_object.away_goals > game_object.home_goals && game_object.away_team_id == team_id
            game_count[game_object.season][0] += 1 
        elsif game_object.away_goals < game_object.home_goals && game_object.home_team_id == team_id
            game_count[game_object.season][0] += 1
        end
        game_count[game_object.season][1] += 1
        game_count
    end

    def game_check(game_goals, goals, find)
        if find == "high"
            if goals < game_goals
                goals = game_goals
            end
        elsif find == "low"
            if goals > game_goals
                goals = game_goals
            end
        end
        goals
    end

    def team_by_team(team_id)
        tbt = {}
        games.each do |game|
            if game.away_team_id == team_id 
                tbt = create_team_by_team(game.home_team_id, tbt)
                tbt = update_team_by_team(game.away_goals, game.home_goals, game.home_team_id, tbt)
            elsif game.home_team_id == team_id
                tbt = create_team_by_team(game.away_team_id, tbt)
                tbt = update_team_by_team(game.home_goals, game.away_goals, game.away_team_id, tbt)
            end
        end
        find_ratio(tbt)
    end

    def create_team_by_team(team_id, team_by_team)
        if team_by_team[team_id].nil?
            team_by_team[team_id] = [0, 0]
        end
        team_by_team
    end

    def update_team_by_team(team_goals, opponent_goals, opponent_id, team_by_team)
        if team_goals > opponent_goals
            team_by_team[opponent_id][0] += 1
        end
        team_by_team[opponent_id][1] += 1
        team_by_team
    end
end