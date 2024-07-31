class GameStatistics

    def initialize(game_stats)
        @game_stats_data = game_stats # hashes of game objects
    end

    def highest_total_score
        highest_scoring_game = @game_stats_data.max_by do |game_id, game_object|
            game_object.total_goals
        end
        highest_scoring_game[1].total_goals
    end

end