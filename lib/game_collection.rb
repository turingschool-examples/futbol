require 'CSV'
require_relative 'game'

class GameCollection
  attr_reader :games

  def initialize(games_file_path)
    @games = from_csv(games_file_path)
  end

  def from_csv(games_file_path)
    games = CSV.read(games_file_path, headers: true, header_converters: :symbol)
    games.map do |row|
      Game.new(row)
    end
  end
end
