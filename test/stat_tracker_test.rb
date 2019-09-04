require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game'
require './lib/stat_tracker'
require 'simplecov'
SimpleCov.start

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
end
