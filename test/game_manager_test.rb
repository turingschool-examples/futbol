require './test/test_helper'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def test_it_can_fetch_game_info
    game1 = mock('game 1')
    game1.stubs(:game_id).returns('1')
    game1.stubs(:game_info).returns('game1 info hash')
    game2 = mock('game 2')
    game2.stubs(:game_id).returns('2')
    game2.stubs(:game_info).returns('game2 info hash')
    game3 = mock('game 3')
    game3.stubs(:game_id).returns('3')
    game3.stubs(:game_info).returns('game3 info hash')
    stat_tracker = mock('A totally legit stat_tracker')
    game_array = [game1, game2, game3]
    CSV.stubs(:foreach).returns(nil)
    game_manager = GameManager.new('A totally legit path', stat_tracker)
    game_manager.stubs(:games).returns(game_array)

    assert_equal game1.game_info, game_manager.game_info('1')
    assert_equal game2.game_info, game_manager.game_info('2')
    assert_equal game3.game_info, game_manager.game_info('3')
  end
end
