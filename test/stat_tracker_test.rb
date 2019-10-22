require './test/test_helper'
require 'stat_tracker'

class StatTrackerTest < MiniTest::Test

def setup
  @stat_tracker = StatTracker.new(filename)
end
def test_it_exists
  assert_instance_of StatTracker, stat_tracker
end

end
