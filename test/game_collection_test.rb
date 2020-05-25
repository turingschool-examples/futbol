require './test/helper_test'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @games_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @games_collection.games
  end

  def test_it_can_create_games_objects
    assert_instance_of Game, @games_collection.games.first
  end
end
