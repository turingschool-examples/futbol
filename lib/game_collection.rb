require 'CSV'
require_relative './game'

class GameCollection
  attr_reader :games

  def self.load_data(path)
    games = Hash.new
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      games[row[:game_id]] = Game.new(row)
    end

    GameCollection.new(games)
  end

  def initialize(games)
    @games = games
  end
end
