require "./test/test_helper"
require "./lib/game_collection"

class GameCollectionTest < Minitest::Test

  def setup
    @game_path = "./data/games.csv"
    @game_collection = GameCollection.new(@game_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_game_path_is_correct
    assert_equal './data/games.csv', @game_collection.game_path
  end

end
