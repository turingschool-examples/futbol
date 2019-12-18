require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def test_game_collection_exists
    collection = TeamCollection.new

    assert_instance_of TeamCollection, collection
  end

  def test_game_collection_has_games_instance_variable
    collection = TeamCollection.new

    assert_nil collection.teams
  end

  def test_file_path_locations
    collection = TeamCollection.new

    assert_equal './data/teams.csv', collection.teams_file_path
  end

  def test_game_collection_can_have_csv_data_added
    collection = TeamCollection.new

    refute_nil collection.from_csv
  end
end
