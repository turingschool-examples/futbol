require './test/test_helper'
require './lib/game_teams'
# CHANGE THIS TO SINGULAR ^
require './lib/game_team_collection'


class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_team_collection = GameTeamCollection.new('./data/game_teams_fixture.csv')
    @game_team = @game_team_collection.game_teams_array.first
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_team_collection.game_teams_array
  end

  def test_it_can_create_game_teams_from_csv
    assert_instance_of GameTeams, @game_team
    # change to SINGULAR ^
    assert_equal "2012030221", @game_team.game_id
    assert_equal "John Tortorella", @game_team.head_coach
  end
end
