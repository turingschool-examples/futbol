require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/game_team'
require './lib/game_team_manager'

class GameTeamManagerTest < MiniTest::Test
  def setup
    game_team_path = './data/game_teams_dummy.csv'
    @game_team_manager = GameTeamManager.new(game_team_path, "tracker")
  end
  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_manager
  end

  def test_create_underscore_game_teams
    @game_team_manager.game_teams.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end

  def test_it_can_test_for_alltime_winning_pct
    assert_equal 0.88, @game_team_manager.average_win_percentage("6")
  end
end
