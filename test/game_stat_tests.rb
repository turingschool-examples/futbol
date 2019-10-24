require_relative 'test_helper'
require './lib/game_collection'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./data/test_game_data.csv", "./data/test_game_team_data.csv", "./data/teams.csv")
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_calculate_highest_goal_total
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_percent_visitor_wins
    assert_equal 50.00, @stat_tracker.percent_visitor_wins
    #5 wins in test sample
  end

  def test_percent_visitor_wins
    assert_equal 50.00, @stat_tracker.percent_visitor_wins
    #5 wins in test sample
  end

  def test_percent_ties
    assert_equal 20.00, @stat_tracker.percent_ties
    # 2 ties in test sample
  end
end
