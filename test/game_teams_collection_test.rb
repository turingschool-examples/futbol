require './test/test_helper'
require './lib/game_teams_collection'

class GameTeamsCollectionTest < Minitest::Test
  def setup
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @game_teams = @game_teams_collection.game_teams_array.first
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_teams_collection.game_teams_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of GameTeams, @game_teams
    assert_equal "away", @game_teams.hoa
    assert_equal "LOSS", @game_teams.result
  end
end
