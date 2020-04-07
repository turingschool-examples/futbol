require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_has_attributes
    assert_equal "./test/fixtures/games_fixture.csv", @stat_tracker.game_path
    assert_equal "./data/teams.csv", @stat_tracker.teams_path
    assert_equal "./test/fixtures/games_teams_fixture.csv", @stat_tracker.game_teams_path
  end

end
