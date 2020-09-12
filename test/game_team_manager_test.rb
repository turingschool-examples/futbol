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
    game_team_array = [game_team1, game_team2, game_team3]
    CSV.stubs(:foreach).returns(nil)
    game_team_manager = GameTeamManager.new('A totally legit path', stat_tracker)
    game_team_manager.stubs(:game_teams).returns(game_team_array)

    assert_equal ['1', '2'], game_team_manager.game_ids_by_team('1')
    assert_equal ['3'], game_team_manager.game_ids_by_team('2')
  end
end
