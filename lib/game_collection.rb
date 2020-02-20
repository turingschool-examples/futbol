require './lib/game'
require 'csv'

class GameCollection
  attr_reader :games
  def initialize(game_file_path)
    @games = create_games(game_file_path)
  end

  def create_games(game_file_path)
    game_data = CSV.read(game_file_path, headers: true, header_converters: :symbol)
    game_data.map do |row|
      Game.new(row.to_h)
    end
  end
end
