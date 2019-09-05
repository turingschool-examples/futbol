require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialize
    assert_equal 32, @stat_tracker.teams.length
    assert_equal 7441, @stat_tracker.games.length
    assert_equal 14882, @stat_tracker.game_teams.length
  end


  # Game Statistics Tests

  def test_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  

  def test_count_of_games_by_season
    expected = { '20122013' => 806,
                 '20132014' => 1323,
                 '20142015' => 1319,
                 '20152016' => 1321,
                 '20162017' => 1317,
                 '20172018' => 1355 }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end
end
