require './test/test_helper'
require './lib/game_statistics'
require './lib/stat_tracker'

class GameStatisticsTest < Minitest::Test
  def setup
    @game_path = './fixtures/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_can_find_highest_total_score
    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
    assert_equal 178, @stat_tracker.percentage_visitor_win_helper
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.21, @stat_tracker.percentage_ties
    assert_equal 105, @stat_tracker.percentage_ties_helper
    assert_equal 0.43, @stat_tracker.percentage_home_wins
    assert_equal 213, @stat_tracker.percentage_home_win_helper
  end

  def test_it_can_count_games_by_season
    expected = {"20122013"=>92,
                "20142015"=>109,
                "20152016"=>118,
                "20132014"=>75,
                "20162017"=>74,
                "20172018"=>28}
    assert_equal expected, @stat_tracker.count_of_games_by_season
    assert_equal 496, @stat_tracker.count_of_games_by_season.values.sum
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 4.21, @stat_tracker.average_goals_per_game
  end

  def test_it_can_find_average_goals_per_season
    expected = expected = {"20122013"=>4.17,
                          "20142015"=>4.06,
                          "20152016"=>4.22,
                          "20132014"=>4.37,
                          "20162017"=>4.19,
                          "20172018"=>4.46}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
