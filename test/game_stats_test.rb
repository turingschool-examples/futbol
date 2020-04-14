require './test/test_helper'
require  './lib/game_stats.rb'
require './lib/stat_tracker.rb'

class GameStatsTest < MiniTest::Test

  def setup
    stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
      @game_stats = stat_tracker.game_stats
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_find_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_it_can_find_lowest_scoring_game
    assert_equal 2, @game_stats.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.64, @game_stats.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.27, @game_stats.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.09, @game_stats.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {"20122013" => 3,
                "20132014" => 3,
                "20172018" => 5}
    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_it_can_find_average_goals
    assert_equal 4.09 , @game_stats.average_goals_per_game
  end

  def test_it_can_return_a_seaon_with_average_goals
    assert_equal ({"20172018" => 3.8, "20132014" => 4.0, "20122013" => 4.67}), @game_stats.average_goals_by_season
  end
end
