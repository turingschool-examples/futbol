require_relative 'game'
require 'CSV'

class GameCollection
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    game_array = []
      CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol) do |row|
        game_array << Game.new(row)
      end
    game_array
  end
end
