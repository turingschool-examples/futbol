require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require "./lib/game"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def setup
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end
end
