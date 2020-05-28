require "./lib/game_statistics"
require "minitest/autorun"
require "minitest/pride"

class GameStatisticsTest < MiniTest::Test

  def setup
    game_path = './game_stats_fixtures/games_fixtures.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = GameStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of GameStatistics, @stat_tracker
    assert_equal './game_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './game_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './game_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end

  def test_it_gets_highest_total_score
    assert_instance_of Integer, @stat_tracker.highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    assert_instance_of Integer, @stat_tracker.lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_gets_all_total_scores
    assert_instance_of Array, @stat_tracker.all_total_scores
    assert_equal 19, @stat_tracker.all_total_scores.count
    assert_equal true, @stat_tracker.all_total_scores.all? {|score| score.is_a?(Integer)}
  end

  def test_it_gets_percent_home_wins
    assert_instance_of Float, @stat_tracker.percentage_home_wins
    assert_equal 68.42, @stat_tracker.percentage_home_wins
  end

  def test_it_gets_percent_visitor_wins
    assert_instance_of Float, @stat_tracker.percentage_visitor_wins
    assert_equal 26.32, @stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_number_of_games_played
    assert_equal 19.0, @stat_tracker.total_games_played
  end

  def test_it_gets_percent_ties
    assert_equal 5.26, @stat_tracker.percentage_ties
  end
end
