require 'csv'
require 'game.rb'

class GameStatics
    attr_reader :games

    def self.from_csv(locations[:games]. Game)

        new(game)
    end

    #alternative 
    #def self.from_csv(locations)
    #game_file = locations[:games]
    #games = CSV.read(games_file, headers :true).map do |row|
    #Game.new(row)
    #end
    #new(game)
    #end
    end
end