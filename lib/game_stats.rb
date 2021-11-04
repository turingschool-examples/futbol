require 'csv'
require_relative "game.rb"

class GameStats < Game
    attr_reader :games

    def initialize(file)
        @games = self.format(file)
        # require "pry"; binding.pry
    end

    def format(file)
        game_file = CSV.read(file, headers: true, header_converters: :symbol)
        game_file.map do |row|
            Game.new(row)
        end
    end

    def highest_total_score
      @games.map do |game|
        (game.away_goals.to_i + game.home_goals.to_i)
      end.max
    end

    def lowest_total_score
      @games.map do |game|
        (game.away_goals.to_i + game.home_goals.to_i)
        require "pry"; binding.pry
      end.min
    end


end
