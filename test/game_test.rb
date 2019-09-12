require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @sample_data = '2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null'
    @game = Game.new(@sample_data)

    @stat_tracker = StatTracker.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

end
