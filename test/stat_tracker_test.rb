require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
    games: './test/fixtures/games_truncated.csv',
    teams: './data/teams.csv',
    game_teams: './test/fixtures/game_teams_truncated.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_attributes
    assert_equal './test/fixtures/games_truncated.csv', @stat_tracker.game_path
    assert_equal './data/teams.csv', @stat_tracker.team_path
    assert_equal './test/fixtures/game_teams_truncated.csv', @stat_tracker.game_teams_path
  end
end
