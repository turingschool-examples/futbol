require './test/test_helper'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @file_locations = {
                      games: @game_path,
                      teams: @team_path,
                      game_teams: @game_teams_path
                        }
    @game_manager = GameManager.new(@file_locations)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameManager, @game_manager
    assert_equal [], @game_manager.games
  end

  def test_it_can_add_array_of_all_game_objects
    @game_manager.all
    assert_instance_of Game, @game_manager.games.first
  end
end
