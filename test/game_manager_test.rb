require './test/test_helper'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def setup
    @game_manager = GameManager.new('./data/games.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameManager, @game_manager
    assert_equal [], @game_manager.games
  end

  def test_it_can_add_array_of_all_game_objects
    @game_manager.all
    assert_instance_of Game, @game_manager.games.first
  end
end
