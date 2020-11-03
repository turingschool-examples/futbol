require_relative './test_helper'
require './lib/calculator'

class CalculatorTest < Minitest::Test
  include Calculator

  def setup
    @hashibl_lector = {"20122013"=> 12, "20132014"=> 1}
    @each_with_objectable = {"3"=>{:success=>38, :total=>8}, "6"=>{:success=>46, :total=>14}}
    @ble = {"17"=>{:success=>1, :total=>4}}
  end

  def test_high

    assert_equal ["20122013", 12], high(@hashibl_lector)
  end

  def test_low

    assert_equal ["20132014", 1], low(@hashibl_lector)
  end

  def test_avg

    assert_equal ({"3"=> 4.75, "6"=> 3.2857142857142856}), avg(@each_with_objectable)
  end

  def test_min_avg

    assert_equal ["6", 3.2857142857142856], min_avg(@each_with_objectable)
  end

  def test_max_avg

    assert_equal ["3", 4.75], max_avg(@each_with_objectable)
  end

  def test_win_pct

    assert_equal 0.25, win_pct(@ble)
  end
end
