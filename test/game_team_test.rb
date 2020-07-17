require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def test_it_exists
    test_1 = GameTeam.new('2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7')

    assert_instance_of GameTeam, test_1
  end

  def test_has_attributes
    test_1 = GameTeam.new('2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7')

    assert_equal 2012030221, test_1.game_id
    assert_equal 3, test_1.team_id
    assert_equal 'away', test_1.hOa
    assert_equal 'LOSS', test_1.result
    assert_equal 'OT', test_1.settled_in
    assert_equal 'John Tortorella', test_1.head_coach
    assert_equal 2, test_1.goals
    assert_equal 8, test_1.shots
    assert_equal 44, test_1.tackles
    assert_equal 8, test_1.pim
    assert_equal 3, test_1.power_play_opportunities
    assert_equal 0, test_1.power_play_goals
    assert_equal 44.8, test_1.face_off_win_percentage
    assert_equal 17, test_1.giveaways
    assert_equal 7, test_1.takeaways
  end
end
