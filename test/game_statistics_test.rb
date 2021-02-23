require "./test/test_helper"
# require 'minitest/pride'
# require 'minitest/autorun'
# require './lib/game_statistics'
# require 'csv'
# require 'pry'

class GameStatisticsTest < Minitest::Test
  def setup
    @game_statistics = GameStatistics.new(CSV.parse(File.read("./data/games_to_test.csv"), headers: true))
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_highest_total_score

  end

  def test_lowest_total_score

  end

  def test_percentage_home_wins

  end

  def test_percentage_visitor_wins

  end

  def test_percentage_ties

  end

  def test_count_of_games_by_season

  end

  def test_average_goals_per_game

  end

  def test_average_goals_by_season

  end
end
