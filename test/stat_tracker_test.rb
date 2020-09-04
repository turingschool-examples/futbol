require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    stat_tracker = StatTracker.new("games", "teams", "game_teams")
    assert_instance_of StatTracker, stat_tracker
  end

  def test_readable_attributes
    stat_tracker = StatTracker.new("games", "teams", "game_teams")
    assert_equal "games", stat_tracker.games
    assert_equal "teams", stat_tracker.teams
    assert_equal "game_teams", stat_tracker.game_teams
  end
end