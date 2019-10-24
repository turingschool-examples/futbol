require_relative 'test_helper'

class GamesCollectionTest < Minitest::Test

  def setup
    @games_collection = GamesCollection.new('./data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_initializes_attributes
    assert_equal 99, @games_collection.games.length
    assert_equal true, @games_collection.games.all? {|game| game.is_a?(Game)}
  end

  def test_it_grabs_highest_total_score
    assert_equal 7, @games_collection.highest_total_score
  end

  def test_it_grabs_lowest_total_score
    assert_equal 1, @games_collection.lowest_total_score
  end
end
