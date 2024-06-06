require 'csv'

class GameStatistics
    attr_reader :games

    def initialize(games)
        @games = games 
    end

    def highest_total_score
        @games.map { |game| game.away_goals + game.home_goals }.max
    end

    def lowest_total_score
        @games.map { |game| game.away_goals + game.home_goals }.min
    end

    def percentage_home_wins
        total_games = @games.length
        home_wins = @games.count { |game| game.home_goals > game.away_goals }
        (home_wins.to_f / total_games * 100).round(2)
    end

    def percentage_visitor_wins
        total_games = @games.length
        away_wins = @games.count { |game| game.away_goals > game.home_goals }
        (away_wins.to_f / total_games * 100).round(2)
    end

    def percentage_tie_games
        total_games = @games.length
        tie_games = @games.count { |game| game.home_goals == game.away_goals }
        (tie_games.to_f / total_games * 100).round(2)
    end
end