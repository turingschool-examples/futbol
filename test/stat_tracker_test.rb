require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    stat_tracker = StatTracker.new

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_initializes_with_from_csv
    stat_tracker = StatTracker.from_csv

  
    assert_instance_of StatTracker, stat_tracker
  end
end
