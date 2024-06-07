require 'csv'

class GameStatistics
    attr_reader :games

    def initialize(games)
        @games = games 
    end

    # def highest_total_score
    #     @games.map { |game| game.away_goals + game.home_goals }.max
    # end

    # def lowest_total_score
    #     @games.map { |game| game.away_goals + game.home_goals }.min
    # end

    # def percentage_home_wins
    #     total_games = @games.length
    #     home_wins = @games.count { |game| game.home_goals > game.away_goals }
    #     (home_wins.to_f / total_games * 100).round(2)
    # end

    # def percentage_visitor_wins
    #     total_games = @games.length
    #     away_wins = @games.count { |game| game.away_goals > game.home_goals }
    #     (away_wins.to_f / total_games * 100).round(2)
    # end

    # def percentage_tie_games
    #     total_games = @games.length
    #     tie_games = @games.count { |game| game.home_goals == game.away_goals }
    #     (tie_games.to_f / total_games * 100).round(2)
    # end

    # def count_of_games_by_season
    #     games_by_season = Hash.new(0)
    #     @games.each do |game|
    #         games_by_season[game.season] += 1
    #     end
    #     games_by_season
    # end

    # def average_goals_per_game
    #     total_games = @games.length
    #     total_goals = games.sum { |game| game.home_goals + game.away_goals}
    #     (total_goals.to_f / total_games).round(2)
    # end

    # def average_goals_by_season
    #     total_goals_by_season = Hash.new(0)
    #     total_games_by_season = Hash.new(0)
    #     @games.each do |game|
    #         total_goals_by_season[game.season] += game.home_goals + game.away_goals
    #         total_games_by_season[game.season] += 1
    #     end

    #     average_goals_by_season = {}
    #     total_goals_by_season.each_key do |season|
    #         average_goals_by_season[season] = (total_goals_by_season[season].to_f / total_games_by_season[season]).round(2)
    #     end
    #         average_goals_by_season
    # end
end