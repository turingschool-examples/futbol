require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def test_it_exists
    tracker = StatTracker.new

    assert_instance_of StatTracker, tracker
  end

end
