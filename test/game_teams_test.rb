require './test/test_helper'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test
  def setup
    @game_teams = GameTeams.new({hoa: "away", result: "WIN"})
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_has_attributes
    assert_equal "away", @game_teams.hoa
    assert_equal "WIN", @game_teams.result
  end
end
