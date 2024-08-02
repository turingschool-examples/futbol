module SeasonStatistics
    def games_per_season(season)
        game_ids = []
        games.find_all do |game| 
            if game.season == season
                game_ids << game.game_id
            end
        end
        game_ids
    end

    def coaches_wins_losses_ties(game_ids)
        coaches = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                update_coaches(object, coaches)
                update_games(object, coaches)
            end
        end
        coaches
    end

    def update_coaches(game_teams_object, coaches)
        if coaches[game_teams_object.head_coach].nil?
            coaches[game_teams_object.head_coach] = [0, 0, 0]
        end
        coaches
    end

    def update_games(game_teams_object, coaches)
        if game_teams_object.result == 'WIN'
            coaches[game_teams_object.head_coach][0] += 1 
        elsif game_teams_object.result == 'LOSS'
            coaches[game_teams_object.head_coach][1] += 1
        else 
            coaches[game_teams_object.head_coach][2] += 1
        end
        coaches
    end

    def winningest_coach(season)
        ids = games_per_season(season)
        coaches = coaches_wins_losses_ties(ids)
        coaches = percentage_of_wins(coaches)
        highest_percent = coaches.values.max
        (coaches.find {|coach, percent| percent == highest_percent})[0]
    end

    def worst_coach(season)
        ids = games_per_season(season)
        coaches = coaches_wins_losses_ties(ids)
        coaches = percentage_of_wins(coaches)
        lowest_percent = coaches.values.min
        (coaches.find {|coach, percent| percent == lowest_percent})[0]
    end

    def percentage_of_wins(coaches)
        coaches.each_pair do |coach, wins_losses_ties|
            win_percentage = (wins_losses_ties[0].fdiv(wins_losses_ties.sum) * 100).round(2)
            coaches[coach] = win_percentage
        end
        coaches
    end

    def team_shot_goal(game_ids) 
        team_ids = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                team_id_hash(object, team_ids)
                update_shots_goals(object, team_ids)
            end
        end
        team_ids
    end

    def team_id_hash(game_teams_object, team_ids)
        if team_ids[game_teams_object.team_id].nil?
            team_ids[game_teams_object.team_id] = [0, 0]
        end
        team_ids
    end

    def update_shots_goals(game_teams_object, team_ids)
        team_ids[game_teams_object.team_id][0] += game_teams_object.goals
        team_ids[game_teams_object.team_id][1] += game_teams_object.shots
        team_ids
    end

    def goal_shot_ratio(team_ids)
        team_ids.each_pair do |team_id, goals_shots|
            shot_ratio = (goals_shots[0].fdiv(goals_shots[1]))
            team_ids[team_id] = shot_ratio
        end
        team_ids
    end

    def get_team_name(team_id)
        team_info = teams.find {|team| team.team_id == team_id}
        team_info.team_name
    end

    def most_accurate_team(season)
        ids = games_per_season(season)
        teams = team_shot_goal(ids)
        teams = goal_shot_ratio(teams)
        team = teams.max_by {|team_id, ratio| ratio}
        get_team_name(team[0])
    end

    def least_accurate_team(season)
        ids = games_per_season(season)
        teams = team_shot_goal(ids)
        teams = goal_shot_ratio(teams)
        team = teams.min_by {|team_id, ratio| ratio}
        get_team_name(team[0])
    end

    def most_tackles(season)
        ids = games_per_season(season)
        teams = team_tackles(ids)
        most_tackles = teams.values.max
        team_with_most_tackles = teams.find {|team, tackles| tackles == most_tackles }
        team_with_most_tackles
        get_team_name(team_with_most_tackles[0])
    end

    def fewest_tackles(season)
        ids = games_per_season(season)
        teams = team_tackles(ids)
        fewest_tackles = teams.values.min
        team_with_fewest_tackles = teams.find {|team, tackles| tackles == fewest_tackles }
        team_with_fewest_tackles
        get_team_name(team_with_fewest_tackles[0])
    end

    def team_tackles(game_ids)
        team_ids = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                team_id_hashes(object, team_ids)
                update_tackles(object, team_ids)
            end
        end
        team_ids
    end

    def team_id_hashes(game_teams_object, team_ids)
        if team_ids[game_teams_object.team_id].nil?
            team_ids[game_teams_object.team_id] = 0
        end
        team_ids
    end

    def update_tackles(game_teams_object, team_ids)
        team_ids[game_teams_object.team_id] += game_teams_object.tackles
        team_ids
    end
end