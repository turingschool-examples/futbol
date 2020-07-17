require './test/test_helper'
require './lib/game.rb'


class GameTest < Minitest::Test


  def test_it_exists
    game1 = Game.new("Game")

    assert_instance_of Game, game1

  end


end
