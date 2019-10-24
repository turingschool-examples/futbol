require_relative 'test_helper'
require './lib/game_collection'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./data/test_game_data.csv", "./data/games.csv", "./data/teams.csv")
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_calculate_highest_goal_total
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

end
