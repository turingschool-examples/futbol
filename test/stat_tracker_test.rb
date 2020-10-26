require './test/test_helper'

class StatTrackerTest < MiniTest::Test

  def setup
    locations = {
      games: './data/fixture_files/games.csv',
      teams: './data/fixture_files/teams.csv',
      game_teams: './data/fixture_files/game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 66.67, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 33.33, @stat_tracker.percentage_away_wins
  end

  def test_calc_percentage
    assert_equal 40.00, @stat_tracker.calc_percentage(2, 5)
  end
end
