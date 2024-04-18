

module GameStats

    def count_of_games_by_season 
        games_per_season = Hash.new(0)
        @games.each do |game|
            if games_per_season.has_key?(game.season_id)
            games_per_season[game.season_id] += 1
            else
            games_per_season[game.season_id] = 1
            end
        end
        games_per_season
    end
      




    # games_of_season = []
    #     @games.map do |game|
    #         games_of_season = game.season_id
    #     end
    #     games_of_season
    # end





    # def count_of_games_by_season(games)
    #     # games_by_season = {}
    #     # @games.each do |game|
    #     #     games_by_season.store(game.season_id, game.season_id.count)
    #     # end
    #     # games_by_season
    # end

    # def average_goals_per_game
        
    # end

    # def average_goals_by_season

    # end
end