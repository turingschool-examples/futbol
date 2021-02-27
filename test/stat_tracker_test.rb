require_relative 'test_helper'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      # games: './data/games.csv',
      # teams: './data/teams.csv',
      # game_teams: './data/game_teams.csv'
      games: './data/games_truncated.csv',
      game_teams: './data/game_teams_truncated.csv',
      teams: './data/teams.csv',
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    @stat_tracker.stubs(:games).returns("Games Array")
    assert_equal "Games Array", @stat_tracker.games
  end

  #Game Statistics Tests

  def test_it_can_find_the_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_percentage_of_two_arrays_lengths
    array1 = ["1", "2", "3"]
    array2 = ["3", "4", "5", "6", "7", "8", "9"]

    assert_equal 0.43, @stat_tracker.percentage(array1, array2)
  end

  def test_lowest_total_score

    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins

    assert_equal 0.54, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins

    assert_equal 0.42, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties #added one "TIE" result to truncated_data

    assert_equal 0.04, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    skip

    assert_equal ({"20122013"=>49}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    skip
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    skip
    assert_equal ({"20122020"=>12345}), @stat_tracker.average_goals_by_season
  end

  # def test_quick_counter
  #   assert_equal 49, @stat_tracker.quick_count
  # end

  #League Statistics Tests

  def test_it_counts_teams
    skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  #Season Statistics Tests

  #Team Statistics Tests
  def test_winningest_coach_best_win_percentage_for_season

    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_highest_total_score
    skip
   @game1 = mock
   @game2 = mock
   @game1.stubs(:total_score).returns(100)
   @game2.stubs(:total_score).returns(1)
   @games = [@game1, @game2]
   csv_loadable = mock
   csv_loadable.stubs(:load_csv_data)
   csv_loadable.stubs(:load_csv_data).with('game_path', Game).returns(@games)
   stat_tracker = StatTracker.new('game_team_path', 'game_path', 'teams_path', csv_loadable)

   assert_equal 100, stat_tracker.highest_total_score
  end

  #   # => with says that whenever we see the items in the parenthesis, please give back the thing after the returns, which right now is the array of mocks
end

## Consider separate class that calculates games statistics

### Still need to call stat_tracker.highest_total_score. How we do we pass the games data back and forth between the stat tracker and the game manager?
