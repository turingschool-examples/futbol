require "./test/test_helper"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @stats = StatTracker.from_csv
  end

  def test_it_is_a_stat_tracker
    assert_instance_of StatTracker, @stats
  end

  def test_it_has_access_to_other_classes
    require "pry"; binding.pry
    assert_instance_of Games, @stats.games[0]
    assert_equal 6, @stats.games.count
    assert_instance_of Teams, @stats.teams[0]
    assert_equal 5, @stats.teams.count
    assert_instance_of GameTeams, @stats.game_teams[0]
    assert_equal 12, @stats.game_teams.count
  end
end
