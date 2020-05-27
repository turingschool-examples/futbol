

require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './test/data/game_teams.csv'

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

  def test_tracker_can_fetch_data
    assert_equal 60, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end
end