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
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_goal_total
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_can_get_average_goals_per_season
    expected = {
      "20122013" => 3.60,
      "20132014" => 5.00,
      "20142015" => 2.00,
      "20152016" => 6.00,
      "20162017" => 3.00,
      "20172018" => 4.00
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
