require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/game_team_collection"

class GameTeamCollectionTest < Minitest::Test
  def setup
    @game_teams = GameTeamCollection.new('./test/data/game_teams.csv')
  end

  def test_it_exist
    assert_instance_of GameTeamCollection, @game_teams
  end

  def test_game_collection_can_fetch_data
    assert_equal 14882, @game_teams.all.count
    assert_instance_of GameTeam, @game_teams.all.first
  end
end
