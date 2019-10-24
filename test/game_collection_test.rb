require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test

  def setup
    @gc = GameCollection.new('./dummy_data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @gc
  end

  def test_initialize_data
    assert_equal 15, @gc.game_instances.count
  end

  def test_count_of_games
    @gc.count_of_games_by_season
    assert_equal Hash, @gc.count_of_games_by_season.class
    assert_equal 4, @gc.count_of_games_by_season.count
    assert_equal 10, @gc.value_maker("20122013").length
  end
end
