require 'csv'
require_relative 'game'

class GameCollection
  def initialize(game_collection_path)
    @game_collection_path = game_collection_path
  end
end
