require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new('./test/data/game_sample.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_read_csv
    assert_equal 10, @game_collection.games.count
  end

  def test_total_games
    assert_equal 10, @game_collection.total_games
  end
end
