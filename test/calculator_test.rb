require_relative './test_helper'
require './lib/calculator'

class CalculatorTest < Minitest::Test
  include Calculator

  def setup
    @hashibl_lector = {"20122013"=> 12, "20132014"=> 1}
  end

  def test_high

    assert_equal ["20122013", 12], high(@hashibl_lector)
  end
end
