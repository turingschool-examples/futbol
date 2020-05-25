require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new(game_params)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end
end
