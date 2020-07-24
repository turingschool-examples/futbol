require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team_data"

class GameTeamDataTest < Minitest::Test

  def test_it_exists
    assert_instance_of GameTeamData, game_team_data 
  end

  #def test_it_has_attributes
  #end

end
