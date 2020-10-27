require './test/test_helper'
require './lib/game_teams'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_teams_manager = GameTeamsManager.new('./data/game_teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamsManager, @game_teams_manager
    assert_equal [], @game_teams_manager.game_teams
  end

  def test_it_can_add_array_of_all_game_team_objects
    @game_teams_manager.all
    assert_instance_of GameTeam, @game_teams_manager.game_teams.first
  end
end
