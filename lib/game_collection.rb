require 'csv'
require_relative 'game'

class GameCollection
  def initialize(game_collection_path)
    @game_collection_path = game_collection_path
  end

  def all_games
    csv = CSV.read("#{@game_collection_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end
end
