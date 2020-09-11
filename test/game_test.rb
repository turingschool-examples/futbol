require "./test/test_helper"
require "./lib/game"
require "mocha/minitest"

class GameTest < Minitest::Test

  def setup
    data = {
      game_id: 2014020006,
      season: "20142015",

    }
    @game_1 = Game.new(data)
  end

  def test_it_can_sum_a_game_total_score_aaa
    @game_1.stubs(:away_goals).returns(2)
    @game_1.stubs(:home_goals).returns(3)
    require "pry"; binding.pry
    assert_equal 5, @game_1.sum_score
  end

end
