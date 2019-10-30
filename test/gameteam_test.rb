require './test/test_helper'
require './lib/gameteam'

class GameteamTest < Minitest::Test

  def setup
    gameteaminfo = {
      game_id: "2012030221",
      team_id: 3,
      HoA: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "8",
      tackles: "44",
      pim: "8",
      powerPlayOpportunities: "3",
      powerPlayGoals: "0",
      faceOffWinPercentage: "44.8",
      giveaways: "17",
      takeaways: "7"
    }
    @gameteam = GameTeam.new(gameteaminfo)
  end

  def test_it_exists
    assert_instance_of GameTeam, @gameteam
  end

  def test_it_has_attributes
    assert_equal "2012030221", @gameteam.game_id
    assert_equal 3, @gameteam.team_id
    assert_equal "away", @gameteam.hoa
    assert_equal "LOSS", @gameteam.result
    assert_equal "OT", @gameteam.settled_in
    assert_equal "John Tortorella", @gameteam.head_coach
    assert_equal 2, @gameteam.goals
    assert_equal 8, @gameteam.shots
    assert_equal 44, @gameteam.tackles
    assert_equal 8, @gameteam.pim
    assert_equal 3, @gameteam.power_play_opportunities
    assert_equal 0, @gameteam.power_play_goals
    assert_equal 44.8, @gameteam.face_off_win_percentage
    assert_equal 17, @gameteam.giveaways
    assert_equal 7, @gameteam.takeaways
  end

  def test_result
    assert_equal false, @gameteam.win?
    assert_equal true, @gameteam.loss?
    assert_equal false, @gameteam.tie?
  end
end
