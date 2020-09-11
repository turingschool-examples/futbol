require "./test/test_helper"
require "./lib/game"

class GameTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv
  end

  def test_it_exists
    assert_instance_of Game, @stat_tracker.games_manager.games.first
  end

end
