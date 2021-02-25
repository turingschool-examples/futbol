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

  #Game Statistics Tests
 
  def test_percentage_of_two_arrays_lengths
    array1 = ["1", "2", "3"]
    array2 = ["3", "4", "5", "6", "7", "8", "9"]

    assert_equal 42.86, @stat_tracker.percentage(array1, array2)
  end

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 53.85, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 41.67, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties #added one "TIE" result to truncated_data
    assert_equal 4.0, @stat_tracker.percentage_ties
  end
  
  #League Statistics Tests

  def test_it_counts_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end
  
  #Season Statistics Tests
  
  
  #Team Statistics Tests


end
