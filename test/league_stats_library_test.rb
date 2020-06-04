require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/statistics_library'
require './lib/league_stats_library'

class LeagueStatsLibraryTest < MiniTest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @league_stats = LeagueStatsLibrary.new(@info)
  end

  def test_it_exists
    assert_instance_of LeagueStatsLibrary, @league_stats
  end

  def test_it_can_do_count_of_teams
    assert_equal 6, @league_stats.count_of_teams
  end

  def test_it_can_determine_best_offense
    assert_equal "FC Dallas", @league_stats.best_offense
  end

  def test_it_can_determine_worst_offense
    assert_equal "Houston Dynamo", @league_stats.worst_offense
  end

  def test_it_can_determine_highest_scoring_visitor
    assert_equal "FC Dallas", @league_stats.highest_scoring_visitor
  end

  def test_it_can_determine_lowest_scoring_visitor
    assert_equal "Houston Dynamo", @league_stats.lowest_scoring_visitor
  end

  def test_it_can_determine_highest_scoring_home_team
    assert_equal "FC Dallas", @league_stats.highest_scoring_visitor
  end

  def test_it_can_determine_lowest_scoring_home_team
    assert_equal "Houston Dynamo", @league_stats.lowest_scoring_visitor
  end
end
