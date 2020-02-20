require './test/test_helper'
require "minitest/autorun"
require "minitest/pride"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @info = {
            game: "./test/fixtures/games_truncated.csv",
            team: "./test/fixtures/teams_truncated.csv",
            game_team: "./test/fixtures/game_teams_truncated.csv"
            }
    @stat_tracker = StatTracker.from_csv(@info)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_instance_of GameTeamCollection, @stat_tracker.game_team_collection
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_biggest_blowout
    assert_equal 2, @stat_tracker.biggest_blowout
  end
end
