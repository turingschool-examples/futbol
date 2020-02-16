require_relative 'test_helper'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test

  def setup
    @game = {
      game_id: "2012030221",
      team_id: "3",
      home_away: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "8",
      tackles: "44",
      pim: "8",
      power_play_opps: "3",
      power_play_goals: "0",
      face_off_win_pct: "44.8",
      giveaways: "17",
      takeaways: "7"
    }
  end

  def test_it_exists
    game_team3 = GameTeams.new(@game)

    assert_instance_of GameTeams, game_team3
  end

end
