

module GameStats

    def count_of_games_by_season 
        games_per_season = Hash.new(0)
        @games.each do |game|
            games_per_season[game.season_id] += 1
        end
        games_per_season
    end

    def average_goals_per_game
        average_of_games = []
        @games.each do |game|
            average_of_games << game.away_goals.to_f
            average_of_games << game.home_goals.to_f
        end
        average_of_games = average_of_games.sum / average_of_games.size
        average_of_games.round(2) / 2 
    end

    def average_goals_by_season
        average_goals_per_season = {}
        @games.each do |game|
            if average_goals_per_season.has_key?(game.season_id)
                average_goals_per_season[game.season_id] += average_goals_per_season
            end
        end
    end
end