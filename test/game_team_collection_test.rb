require './test/helper_test'
require './lib/game_team'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test
  def setup
    @game_team_collection = GameTeamCollection.new("./test/fixtures/game_teams_truncated.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_team_collection.game_teams
  end

  def test_it_can_create_games_objects
    assert_instance_of GameTeam, @game_team_collection.game_teams.first
  end
end
