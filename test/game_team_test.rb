require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @test1 = GameTeam.new('
      2012030221,
      3,
      away,
      LOSS,
      OT,
      John Tortorella,
      2,
      8,
      44,
      8,
      3,
      0,
      44.8,
      17,
      7
    ')
  end

  def test_it_exists
    assert_instance_of GameTeam, @test1
  end

  def test_has_attributes
    assert_equal 2012030221, @test1.game_id
    assert_equal 3, @test1.team_id
    assert_equal 'away', @test1.hOa
    assert_equal 'LOSS', @test1.result
    assert_equal 'OT', @test1.settled_in
    assert_equal 'John Tortorella', @test1.head_coach
    assert_equal 2, @test1.goals
    assert_equal 8, @test1.shots
    assert_equal 44, @test1.tackles
    assert_equal 8, @test1.pim
    assert_equal 3, @test1.power_play_opportunities
    assert_equal 0, @test1.power_play_goals
    assert_equal 44.8, @test1.face_off_win_percentage
    assert_equal 17, @test1.giveaways
    assert_equal 7, @test1.takeaways
  end
end
