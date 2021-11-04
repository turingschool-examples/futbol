require 'csv' 
require_relative 'game.rb'

class GameStats < Game
    attr_reader :games 

    def initialize(file)
        @games = self.format(file)

    end

    def format(file)
        game_file = CSV.read(file, headers: true, header_converters: :symbol)
        game_file.map do |row|
            Game.new(row)
        end
    end
end