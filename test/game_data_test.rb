require "minitest/autorun"
require "minitest/pride"
require "./lib/game_data"
require "csv"

class GameDataTest < Minitest::Test

  def setup
    
  end

  def test_it_exists
    assert_instance_of GameData, @game_data
  end

  #def test_it_has_attributes
  #end

end
