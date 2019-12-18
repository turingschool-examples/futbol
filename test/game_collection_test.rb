require_relative '../test_helper'
require "minitest/autorun"
require 'minitest/pride'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    csv_file_path = 
    @game_collection = GameCollection.new(csv_file_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end
end
