require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    @collection = GameCollection.new('./test/data/game_sample.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @collection
  end

  def test_it_can_read_csv
    assert_equal 10, @collection.all.length
  end

  def test_total_games
    assert_equal 10, @collection.total_games
  end
end
