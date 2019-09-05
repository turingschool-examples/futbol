require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists
    skip
    assert_instance_of Game, @game
  end

end
