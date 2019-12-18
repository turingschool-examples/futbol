require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new({season: "20122013", away_goals: 3, home_goals: 4})
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal "20122013", @game.season
    assert_equal 3, @game.away_goals
    assert_equal 4, @game.home_goals
  end
end
