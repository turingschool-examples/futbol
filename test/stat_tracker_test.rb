require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup

  end

  def test_a_stat_tracker_exists
    stat_tracker = StatTracker.new('games', 'teams', 'team_games')

    assert_instance_of StatTracker, stat_tracker
  end

  def test_can_create_stat_tracker_from_csv

  end
end