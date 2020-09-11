require "./lib/game_team"
require "./test/test_helper"

class GameTeamTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv
  end

  def test_it_exists
    assert_instance_of GameTeam, @stat_tracker.game_teams_manager.game_teams.first
  end

end
