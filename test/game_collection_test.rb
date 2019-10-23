require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    @collection = GameCollection.new('./test/data/game_sample.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @collection
  end

  def test_it_can_read_csv
    assert_equal 10, @collection.all_games.length
  end

  def test_count_of_games_by_season
    expected = {
      "20192020"=>2,
      "20202021"=>2,
      "20212022"=>2,
      "20222023"=>2,
      "20232024"=>2
    }
    assert_equal expected, @collection.count_of_games_by_season
  end
end
