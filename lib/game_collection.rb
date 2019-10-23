require_relative 'game'
require 'CSV'

class GameCollection
  attr_reader :games, :game_objs

  def initialize(csv_file_path)
    @game_objs = []
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    game_obj = 0
    csv.map do |row|
      game_obj = Game.new(row)
      @game_objs << game_obj
    end
  end
end
