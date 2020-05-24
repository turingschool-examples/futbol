require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/game_teams_fixture.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of StatTracker, @stat_tracker
    assert_equal './fixtures/games_fixture.csv', @stat_tracker.games
    assert_equal './fixtures/teams_fixture.csv', @stat_tracker.teams
    assert_equal './fixtures/game_teams_fixture.csv', @stat_tracker.game_teams
  end

end
