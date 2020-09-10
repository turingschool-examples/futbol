require "minitest/autorun"
require "minitest/pride"
require './lib/stat_tracker'
require "./lib/game_statistics"
require "./lib/league_statistics"
require "pry";

class LeagueStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @league_statistics = LeagueStatistics.new(@stat_tracker)
  end

  def test_it_exists

    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_can_count_teams
    # skip
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_it_can_find_best_offense
  # skip
    assert_equal "FC Dallas", @league_statistics.best_offense
  end

  def test_it_can_find_worst_offense

    assert_equal "Houston Dynamo", @league_statistics.worst_offense
  end

  def test_it_can_find_highest_scoring_visitor
    # skip
    assert_equal "Houston Dynamo", @league_statistics.highest_scoring_visitor
  end

  def test_it_can_find_highest_scoring_home_team
    skip
    assert_equal "FC Dallas", @league_statistics.highest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_visitor
    skip
    assert_equal "FC Dallas", @league_statistics.lowest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_home_team
    skip
    assert_equal "Houston Dynamo", @league_statistics.lowest_scoring_home_team
  end
end
