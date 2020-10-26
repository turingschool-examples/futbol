require './test/test_helper'

class StatTrackerTest < MiniTest::Test

  def setup
    locations = {
      games: './data/fixture_files/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/fixture_files/game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

# League Statistics Methods
  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_team_with_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_team_with_worst_offense
    assert_equal "Houston Dynamo", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end
end
