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

    end
# game teams - that data comes in as parameter

# now we have an array of all the game ids per season 

# for each game_id - 
# method to get all unique names of coaches for matching game ids
# method to get all the game id
# 
# look at coach - if it doesn't exist add coach to hash {coach = key, win/loss/ties = value}
# - if it does exists add the win/loss/tie
# method to count the number of games in the season

# method to count wins losses and ties and create percentage
# 
end