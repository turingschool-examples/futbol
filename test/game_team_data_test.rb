require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team_data"

class GameTeamDataTest < Minitest::Test

  def test_it_exists
    game_team_data = GameTeamData.new
    assert_instance_of GameTeamData, game_team_data
  end

  def test_it_can_create_many_objects
    game_team_data = GameTeamData.create_objects

    assert_equal "away", game_team_data[0].hoa 
  end

end
