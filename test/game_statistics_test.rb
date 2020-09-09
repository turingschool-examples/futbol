require_relative 'test_helper'

class GameStatistcsTest < Minitest::Test

#||= memoization, avoid calling method when method has already been ran.
# saves time and computing power.
  def setup
    game_path = './data/games.csv'

    @stat_tracker ||= StatTracker.from_csv({games: game_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end
  #percentage_ties	Percentage of games that has resulted in a tie (rounded to the nearest 100th), float
end
