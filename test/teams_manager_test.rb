require "./test/test_helper"
require "./lib/teams_manager"

class TeamsManagerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv
    @teams_manager = @stat_tracker.teams_manager
  end

  def test_it_exists
    assert_instance_of TeamsManager, @teams_manager
  end

  def test_it_can_count_teams
    assert_equal 5, @teams_manager.count_of_teams
  end
end
