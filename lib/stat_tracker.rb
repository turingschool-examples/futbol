require 'csv'
require './lib/games.rb'

class StatTracker

  def initialize

  end

  def self.from_csv(locations)
    games = []
    game_csv = CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row)
      games << game
    end
    games
  end
end
