require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require 'csv'

class GameCollectionTest < Minitest::Test
  def setup
    @game_file_path = './data/little_games.csv'
    @game_collection = GameCollection.new(@game_file_path)

  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
    assert_equal 4, @game_collection.games.length
  end
end
