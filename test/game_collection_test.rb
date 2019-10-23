require './test/test_helper'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test

  def setup
    @game_collection = GameCollection.new("./data/games_sample.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_total_games
    @game_collection.create_games('./data/games_sample.csv')
    assert_equal 3, @game_collection.total_games.length
  end

  def test_it_can_calculate_highest_total_score
    # look at our dumb file and figure out what that is
    assert_equal 5, @game_collection.highest_total_score
  end

  def test_it_can_calculate_percentage_ties
    assert_equal (1/7.to_f).round(2), @game_collection.percentage_ties
  end

end
