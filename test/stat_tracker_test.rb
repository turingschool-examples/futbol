require_relative 'test_helper'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/games_truncated.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams_truncated.csv'
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end
end
