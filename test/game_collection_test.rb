require_relative 'test_helper'
require_relative '../lib/game_collection'

class GamecollectionTest < Minitest::Test

  def test_it_exists
    game_path = "./test/dummy_game_data.csv"
    game_collection = GameCollection.new(game_path)

    assert_instance_of GameCollection, game_collection
  end
end
