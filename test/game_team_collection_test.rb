require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team_collection"
require "./lib/game_team"

class GameTeamCollectionTest < Minitest::Test

  def setup
    @file_path = "./test/fixtures/game_teams_truncated"
    @game_team_collection = GameTeamCollection.new(@file_path)
  end
  
  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end
end
