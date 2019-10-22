require_relative 'test_helper'

class GamesCollectionTest < Minitest::Test

  def setup
    @game_1 = Game.new
    @game_2 = Game.new
    @games_array = [@game_1, @game_2]
    @games_collection = GamesCollection.new(@games_array)
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_initializes_attributes
    assert_equal @games_array, @games_collection.games
  end
end
