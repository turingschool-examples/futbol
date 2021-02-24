require "./test/test_helper"
# require 'minitest/pride'
# require 'minitest/autorun'
# require './lib/game_manager'
# require 'csv'
# require 'pry'

class GameManagerTest < Minitest::Test
  def setup
    @game_statistics = GameManager.new(CSV.parse(File.read("./data/games_to_test.csv"), headers: true))
  end

  def test_it_exists
    assert_instance_of GameManager, @game_statistics
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
