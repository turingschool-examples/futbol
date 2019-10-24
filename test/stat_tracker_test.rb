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

  def test_it_can_count_games_by_season
    expected = {
      20122013 => 5,
      20132014 => 1,
      20152016 => 1,
      20162017 => 2,
      20172018 => 1
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end
end
