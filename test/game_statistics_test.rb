require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require "./lib/game_data"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def setup
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_game_statistics_is_an_instance_of_game_data
    assert_instance_of GameData, @game_statistics.all_games[1]
  end

  def test_total_score
    assert_equal 5, @game_statistics.highest_total_score
    assert_equal 1, @game_statistics.lowest_total_score
  end

  def test_it_can_determine_percentages
    assert_equal 40, @game_statistics.percentage_of_home_wins
    assert_equal 40, @game_statistics.percentage_of_visitor_wins
    assert_equal 40, @game_statistics.percentage_of_ties
  end
end
