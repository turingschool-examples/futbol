require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_team'
require './test/test_helper'

class GameTeamTest < Minitest::Test

  def setup
    @gameteam = GameTeam.new
  end

  def test_it_exists
    skip
    assert_instance_of GameTeam, @gameteam
  end

end
