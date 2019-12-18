require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def test_game_collection_exists
    collection = GameCollection.new

    assert_instance_of GameCollection, collection
  end

  def test_game_collection_has_games_instance_variable
    collection = GameCollection.new

    assert_nil collection.games
  end

  def test_file_path_locations
    collection = GameCollection.new

    assert_equal './data/games.csv', collection.games_file_path
  end

  def test_game_collection_can_have_csv_data_added
    collection = GameCollection.new

    refute_nil collection.from_csv
  end
end
 