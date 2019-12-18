require_relative './test_helper'
require 'CSV'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new()
  end

  def test_a_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end
end
