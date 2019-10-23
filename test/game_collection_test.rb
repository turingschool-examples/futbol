require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    @collection = GameCollection.new('./test/data/game_sample.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @collection
  end
end
