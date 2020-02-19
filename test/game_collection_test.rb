require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @csv_file_path = "./test/fixtures/games_truncated.csv"
    @game_collection = GameCollection.new(@csv_file_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_equal [], @game_collection.games
    assert_equal "./test/fixtures/games_truncated.csv", @game_collection.csv_file_path
  end
end
