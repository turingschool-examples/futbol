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
end
