require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/game_collection"

class GameCollectionTest < Minitest::Test
  def setup
    @games = GameCollection.new('./test/data/games.csv')
  end

  def test_it_exist
    assert_instance_of GameCollection, @games
  end

  def test_game_collection_can_fetch_data
    assert_equal 480, @games.all.count
    assert_instance_of Game, @games.all.first
  end
end
