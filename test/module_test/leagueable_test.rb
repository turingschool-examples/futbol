require "minitest/autorun"
require "minitest/pride"
require "./lib/leagueable"
require "./lib/stat_tracker"


class LeagueableModuleTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_count_of_teams
    assert_equal 3, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Houston Dynamo", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Chicago Fire" , @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "string", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "string", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "string", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "string", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "string", @stat_tracker.lowest_scoring_visitor
  end

  def test_winningest_team
    assert_equal "string", @stat_tracker.winningest_team
  end
  def test_best_fans
    assert_equal "string", @stat_tracker.best_fans
  end
  def test_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end
