require './test/helper_test'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @
  end
end
