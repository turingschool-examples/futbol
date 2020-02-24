require './test/test_helper'
require "minitest/autorun"
require "minitest/pride"
require 'mocha/minitest'
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @info = {
            games: "./test/fixtures/games_truncated.csv",
            teams: "./test/fixtures/teams_truncated.csv",
            game_teams: "./test/fixtures/game_teams_truncated.csv"
            }

    @info_for_averages = {
                          games: "./test/fixtures/games_average_truncated.csv",
                          teams: "./test/fixtures/teams_truncated.csv",
                          game_teams: "./test/fixtures/game_teams_average_truncated.csv"
                          }

    @stat_tracker = StatTracker.from_csv(@info)
    @stat_tracker_average = StatTracker.from_csv(@info_for_averages)
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

  def test_it_can_count_the_games_by_season
    expected = {"20122013"=>7, "20132014"=>3}

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal (4.50), @stat_tracker.average_goals_per_game
  end

  def test_it_can_show_average_goals_by_season
    expected = {"20122013"=>4.71, "20132014"=>4.00}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_it_can_get_home_wins_percentage
    assert_equal 0.6, @stat_tracker.percentage_home_wins
  end

  def test_it_can_get_away_win_percentages
    assert_equal 0.3, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_get_tied_percentage ## refactor with new data pool to grab real percentage instead of stub
    @stat_tracker.stubs(:percentage_ties).returns(0.10)

    assert 0.10, @stat_tracker.percentage_ties
  end

  def test_it_can_count_number_of_teams
    assert_equal 9, @stat_tracker.count_of_teams
  end

  def test_it_can_find_the_best_offense
    assert_equal "Real Salt Lake", @stat_tracker_average.best_offense
  end

  def test_it_can_find_the_worst_offense
    assert_equal "Orlando Pride", @stat_tracker_average.worst_offense
  end

  def test_it_can_find_the_worst_defence
    assert_equal "Chicago Fire", @stat_tracker_average.worst_defense
  end

  def test_it_can_find_the_best_defence
    assert_equal "Real Salt Lake", @stat_tracker_average.best_defense
  end

  def test_it_can_return_team_with_most_tackles
    assert_equal "FC Dallas", @stat_tracker_average.most_tackles("20122013")
  end
end
