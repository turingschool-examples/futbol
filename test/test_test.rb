require_relative 'test_helper'
require './lib/test'

class TestTest < Minitest::Test

  def test_it_exists
    test = Test.new

    assert_instance_of Test, test
  end
end
