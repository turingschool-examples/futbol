require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_table'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'

class GameTest < Minitest::TestTake

  def test_it_exists
    game = Game.new(data)
  assert_instance_of Game, game
  end

end
