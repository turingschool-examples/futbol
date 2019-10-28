require_relative 'test_helper'
require_relative 'game_collection'
require_relative 'stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./test/dummy_game_data.csv", "./test/dummy_game_team_data.csv", "./test/dummy_team_data.csv")
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_goal_total
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 33.33, @stat_tracker.percentage_home_wins
    #3 wins in test sample
  end

  def test_percentage_visitor_wins
    assert_equal 41.67, @stat_tracker.percentage_visitor_wins
    #5 wins in test sample
  end

  def test_percentage_ties
    assert_equal 25.00, @stat_tracker.percentage_ties
  end

  def test_it_can_give_number_of_games_in_season
    expected = {
    "20122013" => 5,
    "20132014" => 1,
    "20142015" => 1,
    "20152016" => 2,
    "20162017" => 2,
    "20172018" => 1
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_count_goals_per_season
    expected = {
    "20122013" => 18,
    "20132014" => 5,
    "20142015" => 2,
    "20152016" => 12,
    "20162017" => 6,
    "20172018" => 4
    }
    assert_equal expected, @stat_tracker.goal_count_per_season
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

  def test_it_can_return_average_goals_per_game
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end
end
