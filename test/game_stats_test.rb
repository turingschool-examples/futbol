require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/games'
require_relative '../lib/teams'
require_relative '../lib/game_teams'

class GameStatsTest < MiniTest::Test

  def setup
    locations = { games: './data/dummy_games.csv', teams: './data/teams.csv', game_teams: './data/dummy_game_teams.csv' }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 50.0, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 41.67, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 8.33, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal ({ '20122013' => 7, '20142015' => 1, '20162017' => 4 }), @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.67, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({'20122013' => 4.57, '20162017' => 4.75, '20142015' => 5.0}), @stat_tracker.average_goals_by_season
  end
end
