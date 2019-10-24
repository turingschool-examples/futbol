require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < MiniTest::Test

  def setup
    @game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
  end

  def setup
    @gc = GameCollection.new('./dummy_data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_average_goals_per_game
    assert_equal 4, @game_collection.average_goals_per_game
  end

  def test_average_goals_per_season
    assert_equal 2.0, @game_collection.ave_goals_per_season_values(20122013)
    assert_equal 2.0, @game_collection.average_goals_per_season[20122013]
    expected_value = {20122013=>2.0, 20152016=>2.17, 20162017=>2.0, 20172018=>1.5}
    assert_equal expected_value,  @game_collection.average_goals_per_season
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
