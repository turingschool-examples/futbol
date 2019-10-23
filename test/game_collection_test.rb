require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
#require './dummy_data/dummy_games'

class GameCollectionTest < MiniTest::Test

  def setup
    csv_path = (CSV.read "./dummy_data/dummy_games.csv", headers: true, header_converters: :symbol)
    @game_collection = GameCollection.new(csv_path)
    # @game = Game.new(csv_path)
  end

  def test_it_exists
skip
    assert_instance_of GameCollection, @game_collection
  end
end
