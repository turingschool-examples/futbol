require_relative 'test_helper'

class GamesCollectionTest < Minitest::Test

  def setup
    @games_array = []
    @games_collection = GamesCollection.new(@games_array)
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end
end
