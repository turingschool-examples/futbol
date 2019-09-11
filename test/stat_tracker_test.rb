require './test/test_helper'
require './lib/stat_tracker'
# require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.new
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialization
    assert_equal ({}), @stat_tracker.games
    assert_equal ({}), @stat_tracker.teams
    assert_equal [], @stat_tracker.game_teams
  end

end
