require 'csv'

class Game
    attr_reader :game_data

    def initialize(game_data)
        @game_data = game_data
    end

    def highest_total_score
        puts 'this score is high lol'
    end
end

