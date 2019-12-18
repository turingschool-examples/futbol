require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test
  def test_game_team_collection_exists
    collection = GameTeamCollection.new

    assert_instance_of GameTeamCollection, collection
  end

  def test_game_team_collection_has_game_team_instance_variable
    collection = GameTeamCollection.new

    assert_nil collection.game_teams
  end

  def test_file_path_location
    collection = GameTeamCollection.new

    assert_equal './data/game_teams.csv', collection.game_teams_file_path
  end

  def test_game_team_collection_can_have_csv_data_added
    collection = GameTeamCollection.new

    refute_nil collection.from_csv
  end
end
