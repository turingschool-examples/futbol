require "./test/test_helper"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def test_it_is_a_stat_tracker
    stats = StatTracker.new

    assert_instance_of StatTracker, stats
  end
end
