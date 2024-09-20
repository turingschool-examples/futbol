require 'csv'
require 'game.rb'

class GameStatistics
    attr_reader :game_data,
                :team_data,
                :stat_tracker

    def initialize(game_data, team_data, stat_tracker)
        @game_data = game_data
        @team_data = team_data
        @stat_tracker = stat_tracker
    end

    def percent_home_wins

    end

    def perecent_vistor_wins

    end

    def highest_total_score

    end

    def lowest_total_score

    end

    def average_goals_per_game
        total_goals = 0
        games = 0
        @game_data.each do |game|
            total_goals += game.away_goals.to_i + game.home_goals.to_i
            games += 1
        end
        average_goals = total_goals / games.to_f
        average_goals.round(2)
    end
    
    def average_goals_by_season
    
    
    
end
