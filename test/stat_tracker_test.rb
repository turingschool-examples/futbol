require './test/test_helper'

class StatTrackerTest < MiniTest::Test

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 5, StatTracker.highest_total_score
  end
end
