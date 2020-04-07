require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.new
  end

end
