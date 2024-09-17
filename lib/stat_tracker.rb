require 'CSV'

class Stattracker
    s










    def percentage_home_wins
        total_games = @games.length
        home_wins = @games.count { |game| game.home_goals > game.away_goals }
            
        percentage = (home_wins.to_f / total_games) * 100
        percentage.round(2)
    end
end