require './test/test_helper'
require './lib/stat_tracker'
class StatTrackerTest < Minitest::Test
  def test_it_exists_and_has_attributes
    stat_tracker = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker
  end
end
