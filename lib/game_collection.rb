require 'csv'
require_relative './game'

class GameCollection
  attr_reader :games
  def initialize(game_data)
    @games = create_games(game_data)
  end

  def create_games(game_data)
    game_data.map do |row|
      Game.new(row.to_h)
    end
  end
end
