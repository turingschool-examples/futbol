require './test/test_helper'
require './lib/game_teams'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @file_locations = {
                      games: @game_path,
                      teams: @team_path,
                      game_teams: @game_teams_path
                        }
    @game_teams_manager = GameTeamsManager.new(@file_locations)
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
