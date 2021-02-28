require_relative 'test_helper'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      # games: './data/games.csv',
      teams: './data/teams.csv',
      # game_teams: './data/game_teams.csv',
      games: './data/games_truncated.csv',
      game_teams: './data/game_teams_truncated.csv'
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

    assert_equal 0.43, @stat_tracker.arry_percentage(array1, array2)
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.54, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.38, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties #added one "TIE" result to truncated_data
    assert_equal 0.04, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>49}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end


 #League Statistics Tests

  def test_it_counts_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def calculate_average_scores
    NEEDS TO BE MOCKED AND STUBBED
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "LA Galaxy", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end


  #Season Statistics Tests

  def test_winningest_coach_best_win_percentage_for_season
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "Mike Babcock", @stat_tracker.worst_coach("20122013")
  end

  def test_most_tackles_by_team_in_season
    assert_equal "FC Dallas", @stat_tracker.most_tackles("20122013")
  end

  def test_fewest_tackles_by_team_in_season
    assert_equal "New York Red Bulls", @stat_tracker.fewest_tackles("20122013")
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

  def test_best_season
    assert_equal "20162017", @stat_tracker.best_season("8")
  end

  def test_worst_season
    assert_equal "20172018", @stat_tracker.worst_season("8")
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("3")
  end

  #Team Statistics Tests

  def test_it_can_find_most_accurate_team
    assert_equal "FC Dallas", @stat_tracker.most_accurate_team("20122013")
  end

  def test_it_can_find_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team("20122013")
  end

  #Helper Methods

   def test_average_goals_by_season
    assert_equal ({"20122013"=>3.92}), @stat_tracker.average_goals_by_season
   end
end
