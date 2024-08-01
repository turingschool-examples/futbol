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
        coaches.values.max
    end

    def worst_coach(season)
        ids = games_per_season(season)
        coaches = coaches_wins_losses_ties(ids)
        coaches = percentage_of_wins(coaches)
        coaches.values.min
    end

    def percentage_of_wins(coaches)
        coaches.each_pair do |coach, wins_losses_ties|
            win_percentage = (wins_losses_ties[0].fdiv(wins_losses_ties.sum) * 100).round(2)
            coaches[coach] = win_percentage
        end
        coaches
    end
end