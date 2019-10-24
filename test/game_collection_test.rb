require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < MiniTest::Test

  def setup
    @game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end
  def test_average_goals_per_game
  skip
    assert_equal 6, @game_collection.average_goals_per_game
  end
end
