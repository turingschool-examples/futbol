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

  def test_total_scores_returns_array_populated_with_all_game_scores_summed
    assert_equal [5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3, 5], @game_collection.total_scores
  end

  def test_highest_total_score
    assert_equal 5, @game_collection.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @game_collection.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
  end 
  
  def test_average_goals_per_game
    assert_equal 4, @game_collection.average_goals_per_game
  end

  def test_average_goals_per_season
    assert_equal 2.0, @game_collection.ave_goals_per_season_values(20122013)
    assert_equal 2.0, @game_collection.average_goals_per_season[20122013]
    expected_value = {20122013=>2.0, 20152016=>2.17, 20162017=>2.0, 20172018=>1.5}
    assert_equal expected_value,  @game_collection.average_goals_per_season
    assert_instance_of GameCollection, @game_collection
  end

  def test_initialize_data
    assert_equal 15, @game_collection.game_instances.count
  end

  def test_count_of_games
    @game_collection.count_of_games_by_season
    assert_equal Hash, @game_collection.count_of_games_by_season.class
    assert_equal 4, @game_collection.count_of_games_by_season.count
    assert_equal 10, @game_collection.value_maker("20122013").length
  end
end
