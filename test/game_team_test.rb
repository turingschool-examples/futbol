require './test/test_helper'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({
      "face_off_win_percentage"=>55.2,
      "game_id"=>2012030221,
      "giveaways"=>4,
      "goals"=>3,
      "head_coach"=>"Claude Julien",
      "hoa"=>"home",
      "pim"=>6,
      "power_play_goals"=>1,
      "power_play_opportunities"=>4,
      "result"=>"WIN",
      "settled_in"=>"OT",
      "shots"=>12,
      "tackles"=>51,
      "takeaways"=>5,
      "team_id"=>6,
      })
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end
end
