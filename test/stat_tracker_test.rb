require_relative 'test_helper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    locations = {
                  games: '../data/games.csv',
                  teams: '../data/teams.csv',
                  game_teams: '../data/game_teams.csv'
                }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end
end
