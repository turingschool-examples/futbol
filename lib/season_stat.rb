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
        teams = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                team_id_hash(object, teams)
                update_shots_goals(object, teams)
            end
        end
        teams
    end

    def team_id_hash(game_teams_object, teams)
        if teams[game_teams_object.team_id].nil?
            teams[game_teams_object.team_id] = [0, 0]
        end
        teams
    end

    def update_shots_goals(game_teams_object, teams)
        teams[game_teams_object.team_id][0] += game_teams_object.goals
        teams[game_teams_object.team_id][1] += game_teams_object.shots
        teams
    end

    def goal_shot_ratio(teams)
        teams.each_pair do |team_id, goals_shots|
            shot_ratio = (goals_shots[0].fdiv(goals_shots[1])).round(2)
            teams[team_id] = shot_ratio
        end
        teams
    end

end