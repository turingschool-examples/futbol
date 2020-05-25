require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

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

  def test_it_has_csv_paths
    assert_equal './data/games_fixture.csv', @stat_tracker.games
    assert_equal './data/teams_fixture.csv', @stat_tracker.teams
    assert_equal './data/game_teams_fixture.csv', @stat_tracker.game_teams
  end
end
