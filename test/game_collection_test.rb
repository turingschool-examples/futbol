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
    assert_equal 8, @game_collection.total_games.length
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 5, @game_collection.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 2, @game_collection.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 2, @game_collection.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    #8 total games
    #2 home wins
    #4 away wins
    #2 ties
    assert_equal 25.00, @game_collection.percentage_home_wins
  end

end
