require './test/test_helper'
require './lib/mathable'
require 'pry'

class GameStatisticsTest < Minitest::Test
  include Mathable
  def test_it_can_average
    assert_equal 2.0, average(10.0, 5.0)
  end

end
