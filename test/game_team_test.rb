require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @gameteam = GameTeam.new
  end

  def test_it_exists

    assert_instance_of GameTeam, @gameteam
  end

end
