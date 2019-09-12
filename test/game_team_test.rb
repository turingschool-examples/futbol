require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @sample_data = '2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7'
    @game_team = GameTeam.new(@sample_data)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

end
