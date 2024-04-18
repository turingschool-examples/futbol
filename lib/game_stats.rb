

module GameStats

    def count_of_games_by_season 
        games_per_season = Hash.new(0)
        @games.each do |game|
            games_per_season[game.season_id] += 1
        end
        games_per_season
    end

    def average_goals_per_game
        all_goals = []
        @games.each do |game|
            all_goals << game.away_goals.to_f + game.home_goals.to_f
        end
        average_of_games = all_goals.sum / all_goals.size
        average_of_games.round(2)
    end
    
    def average_goals_by_season
        average_goals_per_season = {}
        season_count = Hash.new(0)
        
        @games.each do |game|
            season_id = game.season_id
            season_count[season_id] += 1
            average_goals_per_season[season_id] ||= 0
            average_goals_per_season[season_id] += (game.away_goals.to_f + game.home_goals.to_f)
        end
        
        average_goals_per_season.each do |season_id, total_goals|
            average_goals_per_season[season_id] = (total_goals / season_count[season_id]).round(2)
        end
        
        average_goals_per_season
    end

end