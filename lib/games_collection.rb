require 'pry'
require './lib/game'

class GamesCollection
  attr_reader :games
  def initialize(games_file)
    @games_file = games_file
    @games = self.read_file
  end

  def read_file
    data = CSV.read @games_file, headers: true, header_converters: :symbol
    data.map do |row|
      Game.new(row)
    end
  end
end
