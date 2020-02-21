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

  def test_it_can_count_the_games_by_season
    expected = {20122013=>7, 20132014=>3}

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal (4.50), @stat_tracker.average_goals_per_game
  end


end
