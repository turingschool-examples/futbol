require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'
require 'csv'

class StatTrackerTest < Minitest::Test
  def setup
    @new_tracker = StatTracker.new()
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @new_tracker
  end

end
