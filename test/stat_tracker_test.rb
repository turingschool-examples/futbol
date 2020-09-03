require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest
  def test_it_exists
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.new(locations)

    assert_instance_of StatTracker, stat_tracker
  end
end
