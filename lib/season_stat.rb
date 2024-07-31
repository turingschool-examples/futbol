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
                # update game w/l/t for coach
                ### (if coach exists just add w/l/t, else add coach then w/l/t)
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



# method to get all unique names of coaches for matching game ids




### method to count wins losses and ties and create percentage

end