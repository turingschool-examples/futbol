require'./test/test_helper'
require'./lib/stat_tracker'
require'csv'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/game_teams_fixture.csv"})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    skip
    assert_equal "./test/fixtures/games_fixture.csv", @stat_tracker.games_path
    assert_equal "./data/teams.csv", @stat_tracker.teams_path
    assert_equal "./test/fixtures/game_teams_fixture.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end
end
