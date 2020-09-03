# frozen_string_literal: true

require './test/test_helper'

class GameMethodsTest < Minitest::Test
  def test_it_exists
    game_methods = GameMethods.new('location_of_file')

    assert_instance_of GameMethods, game_methods

    assert_equal 'location_of_file', game_methods.file_loc
  end
end
