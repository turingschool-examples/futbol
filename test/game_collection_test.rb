require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < MiniTest::Test

  def setup
    @game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    # @game = Game.new(csv_path)
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
end
