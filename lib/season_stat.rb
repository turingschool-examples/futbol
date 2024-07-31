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
                # coach method
                ### (if coach exists just add w/l/t, else add coach then w/l/t)
            end
        end
        coaches
    end



# method to get all unique names of coaches for matching game ids
# for each game_id - if game_teams.game_id == game_ids && game.hoa == away 
### run check_for_coach method 



### method to count wins losses and ties and create percentage

end