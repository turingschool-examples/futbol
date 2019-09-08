require 'minitest/autorun'
require 'minitest/pride'
require './lib/memoize'
class MemoizeTest < Minitest::Test
  def test_it_does_nothing
    assert true
  end

  def test_it_takes_some_numbers
    arr = [1,10,2,9,3,8]
    m = Memoize.new(arr)

    assert m.is_a? Memoize
  end

  def test_it_sorts
    arr = [1,10,2,9,3,8]
    m = Memoize.new(arr)
    m.sorted
    m.sorted
    m.sorted

    assert_equal [1,2,3,8,9,10], m.sorted
  end

  def test_it_averages
    arr = [1,10,2,9,3,8]
    m = Memoize.new(arr)
    m.average
    m.average
    m.average

    assert_equal 5, m.average
  end




end
