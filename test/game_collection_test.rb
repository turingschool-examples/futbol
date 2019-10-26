require_relative 'test_helper'
require_relative '../lib/game_collection'

class GamecollectionTest < Minitest::Test

  def setup
    game_path = "./test/dummy_game_data.csv"
    @game_collection = GameCollection.new(game_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @game_collection.highest_total_score
  end

  def test_it_can_calculate_lowest_goal_total
    assert_equal 2, @game_collection.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
  end
end
