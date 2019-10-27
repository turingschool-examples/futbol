require './test/test_helper'
require './lib/gameteam'

class GameteamTest < Minitest::Test

  def setup
    gameteaminfo = {
      game_id: "2012030221",
      team_id: 3,
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 8,
      tackles: 44,
      pim: 8,
      power_play_opportunities: 3,
      power_play_goals: 0,
      face_off_win_percentage: 44.8,
      giveaways: 17,
      takeaways: 7
    }
    @gameteam = GameTeam.new(gameteaminfo)
  end

  def test_it_exists
    assert_instance_of GameTeam, @gameteam
  end
end
