require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game_teams_collection"

class GameTeamsCollectionTest < Minitest::Test

  def setup
    game_teams_csv_location = './data/game_teams.csv'
    @game_teams_collection = GameTeamsCollection.new(game_teams_csv_location)

  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
  end

  def test_it_has_attributes
    assert_equal [], @game_teams_collection.collection
  end

  def test_it_can_load_a_csv_file
    @game_teams_collection.load_csv
    assert_equal 14882, @game_teams_collection.collection.count
  end

end
