require './test/test_helper'
require './lib/game'
require 'CSV'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes
    assert_equal 32, @stat_tracker.teams.count
    assert_equal 7441, @stat_tracker.games.count
    assert_equal 14882, @stat_tracker.game_teams.count
  end
end
