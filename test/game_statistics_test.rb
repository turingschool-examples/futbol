require "minitest/autorun"
require "minitest/pride"
require './lib/stat_tracker'
require "./lib/game_statistics"
require "pry";

class GameStatisticsTest < Minitest::Test
  def test_it_exists
    game_statistics = GameStatistics.new

    assert_instance_of GameStatistics, game_statistics
  end
end
