require_relative './helper_class'
require 'CSV'
require './lib/game'

class GameList
    attr_reader :games

    def initialize(path, stat_tracker)
        @games = create_games(path)
    end

    def create_games(path)
        data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
        data.map do |datum|
            Game.new(datum,self)
        end
    end
  
    # def highest_total_score

    # end

end
