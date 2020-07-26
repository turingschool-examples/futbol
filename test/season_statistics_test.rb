require "minitest/autorun"
require "minitest/pride"
require "./lib/season_statistics"
require "./lib/team_data"
require "./lib/game_data"
require "./lib/game_team_data"
require 'csv'

class SeasonStatisticsTest < Minitest::Test

  def setup
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  # Update tests for all new helpers excluding suite

  def test_it_can_print_best_and_worst_coach_by_season
    assert_equal "Claude Julien", @season_statistics.winningest_coach(20122013)
    assert_equal "Dan Bylsma", @season_statistics.worst_coach(20122013)
  end

  def test_can_find_most_and_least_accurate_teams_by_season
    assert_equal "FC Dallas", @season_statistics.most_accurate_team(20122013)
    assert_equal "Sporting Kansas City", @season_statistics.least_accurate_team(20122013)
  end

  def test_can_find_most_and_least_tackles_by_team_by_season
    assert_equal "", @season_statistics.most_accurate_team(20122013)
    assert_equal "", @season_statistics.least_accurate_team(20122013)
  end

end
