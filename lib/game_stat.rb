module GameStat

    def highest_total_score
        @games.map do |game|
            game.away_goals + game.home_goals
        end.max
    end
    
    def lowest_total_score
        @games.map do |game|
            game.away_goals + game.home_goals
        end.min
    end
    
    def percentage_home_wins
        total_games = @games.count
        home_wins = @games.count { |game| game.home_goals > game.away_goals }
        (home_wins.to_f / total_games).round(2)
    end
    
    def percentage_visitor_wins
        total_games = @games.count
        visitor_wins = @games.count { |game| game.away_goals > game.home_goals }
        (visitor_wins.to_f / total_games).round(2)        
    end
    
    # require 'pry';binding.pry
    def percentage_ties
        total_games = @games.count
        ties = @games.count { |game| game.away_goals == game.home_goals }
        (ties.to_f / total_games).round(2)        
    end
    
    def count_of_games_by_season
        count_of_games = Hash.new(0)
        @games.each do |game|
            count_of_games[game.season] += 1
            # require 'pry';binding.pry
        end
        count_of_games
    end
    
    def average_goals_per_game
        total_games = @games.count
        total_goals = @games.sum { |game| game.away_goals + game.home_goals }
        (total_goals.to_f / total_games).round(2)
    end
    
    def average_goals_by_season

    end
end