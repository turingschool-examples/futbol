require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/little_games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
  end

  def test_it_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end

  def test_create_from_csv
    stat_tracker_1 = StatTracker.from_csv(@locations)
    assert_instance_of StatTracker, stat_tracker_1
  end
end
