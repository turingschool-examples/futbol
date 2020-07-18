require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def test_it_exists
    game_statistics = GameStatistics.new
    assert_instance_of GameStatistics, game_statistics
  end

end
