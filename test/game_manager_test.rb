require './test/test_helper'
require './lib/games_manager'

require 'mocha/minitest'

class GameManagerTest < Minitest::Test

  def test_it_exists

    start_tracker = mock
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path , start_tracker)
    csv = mock
    csv.stubs(:foreach).returns([])

    assert_instance_of GamesManager, game_manager
  end

  def test_it_has_attributes

    start_tracker = mock
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path , start_tracker)
    csv = mock
    csv.stubs(:foreach).returns([])

    assert_equal path, game_manager.data_path
    # assert_equal [], game_manager.games
    # assert_instance_of StatTracker, stat_tracker
  end
end
