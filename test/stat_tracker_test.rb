require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

def test_it_exists
  stat_tracker = StatTracker.new
  assert_instance_of StatTracker, stat_tracker
end

def test_return_of_from_csv_is_instance_of_Stat_Tracker
  assert_instance_of StatTracker, StatTracker.from_csv(locations)
end






















end
