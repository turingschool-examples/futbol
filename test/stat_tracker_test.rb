require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'


class StatTrackerTest < MiniTest::Test

  def test_it_exists
    stat_tracker = StatTracker.new


    assert_instance_of StatTracker, stat_tracker

  end

  

end
