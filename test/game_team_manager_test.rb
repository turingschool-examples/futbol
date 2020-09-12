require './test/test_helper'
require './lib/game_team_manager'

class GameTeamManagerTest < Minitest::Test
  def test_it_can_fetch_game_ids_for_a_team
    game_team1 = mock('game_team 1')
    game_team1.stubs(:game_id).returns('1')
    game_team1.stubs(:team_id).returns('1')
    game_team2 = mock('game_team 2')
    game_team2.stubs(:game_id).returns('2')
    game_team2.stubs(:team_id).returns('1')
    game_team3 = mock('game_team 3')
    game_team3.stubs(:game_id).returns('3')
    game_team3.stubs(:team_id).returns('2')
    stat_tracker = mock('A totally legit stat_tracker')
    team_array = [team1, team2, team3]
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)
    team_manager.stubs(:teams).returns(team_array)

    assert_equal ['1', '2'], team_manager.game_ids_by_team('1')
    assert_equal ['3'], team_manager.game_ids_by_team('2')
  end
end
