require "minitest/autorun"
require "minitest/pride"
require "./lib/game_data"
require "csv"

class GameDataTest < Minitest::Test

  def test_it_exists
    game_data = GameData.new

    assert_instance_of GameData, game_data
  end
end
