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
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 50.0, @stat_tracker.percentage_home_wins
    assert_equal 20, @stat_tracker.percentage_home_win_helper
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 27.5, @stat_tracker.percentage_visitor_wins
    assert_equal 11, @stat_tracker.percentage_visitor_win_helper
  end

  def test_it_can_find_percentage_ties
    assert_equal 22.5, @stat_tracker.percentage_ties
    assert_equal 9, @stat_tracker.percentage_ties_helper
  end

  def test_it_can_count_games_by_season
    expected = { '20172018' => 17,
                 '20132014' => 16,
                 '20122013' => 7 }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 4.28, @stat_tracker.average_goals_per_game
  end

  def test_it_can_find_average_goals_per_season
    expected = {'20172018' => 17,
                '20132014' => 16,
                '20122013' => 7 }
    assert_equal expected, @stat_tracker.average_goals_per_season
  end
end
