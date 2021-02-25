require './test/test_helper'
require './lib/games_manager'


class GameManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_instance_of GamesManager, game_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    start_tracker = mock
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_equal 15, game_manager.games.length
    assert_instance_of Game, game_manager.games[0]
    assert_instance_of Game, game_manager.games[-1]
  end
end
