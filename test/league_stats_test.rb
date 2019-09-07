require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/games'
require_relative '../lib/teams'
require_relative '../lib/game_teams'

class LeagueStatsTest < MiniTest::Test

  def setup
    locations = { games: './data/games.csv', teams: './data/teams.csv', game_teams: './data/game_teams.csv' }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "New York Red Bulls", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "New York City FC", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "New York Red Bulls", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor

    assert_equal "Real Salt Lake", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "New York Red Bulls", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_home_team
  end


  def test_winningest_team

    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "New York City FC", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Real Salt Lake"], @stat_tracker.worst_fans
  end
end
