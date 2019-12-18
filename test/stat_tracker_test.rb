require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    our_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

   @stat_tracker = StatTracker.from_csv(our_locations)
 end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_path_locations
    assert_equal './data/games_dummy.csv', @stat_tracker.game_path
    assert_equal './data/teams.csv', @stat_tracker.teams_path
    assert_equal './data/game_teams_dummy.csv', @stat_tracker.game_teams_path
  end
end
