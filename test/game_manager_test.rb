require "minitest/autorun"
require "minitest/pride"
require './lib/stat_tracker'
# require "./lib/game_statistics"
require './lib/game_manager'
require 'mocha/minitest'
# require './data/dummy_game.csv'
require './lib/game'
require "pry";

class GamesManagerTest < Minitest::Test
  def setup
    tracker = mock('Stat_Tracker')
    games_path = './data/dummy_game.csv'
    @games_manager = GamesManager.new(games_path, tracker)
  end
  def test_it_exists
    assert_instance_of GamesManager, @games_manager
  end

  def test_it_can_find_the_highest_total_score
    assert_equal 6, @games_manager.highest_total_score
  end

  def test_it_can_find_the_lowest_total_score
    assert_equal 3, @games_manager.lowest_total_score
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 50.0, @games_manager.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 33.33, @games_manager.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 16.67, @games_manager.percentage_ties
  end

  def test_it_can_count_games_by_season
    expected = {
      "20122013" => 2,
      "20162017" => 2,
      "20142015" => 2
    }
    assert_equal expected, @games_manager.count_games_by_season
  end

  def test_it_can_populate_a_list_of_seasons
    expected = ["20122013","20162017","20142015"]
    assert_equal expected, @games_manager.list_of_seasons
  end

  def test_it_can_find_total_goals
    assert_equal 29, @games_manager.total_goals
  end

  def test_it_find_average_goals_per_game
    assert_equal 4.83, @games_manager.average_goals_per_game
  end

  def test_it_can_find_average_goals_by_season
    expected = {
      "20122013" => 5.5,
      "20162017" => 4.0,
      "20142015" => 5.0
    }
    assert_equal expected, @games_manager.average_goals_by_season
  end

  def test_it_can_find_total_goals_by_season
    season = '20122013'
    assert_equal 11, @games_manager.total_goals_by_season(season)
  end

  def test_it_can_find_average_data_of_goals_by_season
    season = '20122013'
    assert_equal 5.5, @games_manager.average_goals_by_season_data(season)
  end
end
