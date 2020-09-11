require "./test/test_helper"
require "./lib/team"

class TeamTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv
  end

  def test_it_exists
    assert_instance_of Team, @stat_tracker.teams_manager.teams.first
  end

end
