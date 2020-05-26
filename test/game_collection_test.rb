require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require './lib/game'
require 'pry'

class GameCollectionTest < Minitest::Test

  def setup
    file = './data/games_fixture.csv'

    @game_collection = GameCollection.new(file)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_return_games
    assert_equal 4, @game_collection.all.count
  end

end
