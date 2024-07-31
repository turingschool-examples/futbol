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

    end
    
    def percentage_visitor_wins

    end
    
    def percentage_ties

    end
    
    def count_of_games_by_season

    end
    
    def average_goals_per_game

    end
    
    def average_goals_by_season

    end
end