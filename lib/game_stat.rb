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

    end
    
    def average_goals_per_game

    end
    
    def average_goals_by_season

    end
end