require "./test/test_helper"
require './lib/game_manager'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game'
require "pry";

class GamesManagerTest < Minitest::Test
  def setup
    stat_tracker = mock('stat_tracker')
    stat_tracker.stubs(:class).returns(StatTracker)
    @games_manager = GamesManager.new('./data/dummy_game.csv', stat_tracker)
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
    assert_equal 0.38, @games_manager.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.50, @games_manager.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.13, @games_manager.percentage_ties
  end

  def test_it_can_count_games_by_season
    expected = {
      "20122013" => 7,
      "20152016" => 1
    }
    assert_equal expected, @games_manager.count_games_by_season
  end

  def test_it_can_populate_a_list_of_seasons
    expected = ["20122013","20152016"]
    assert_equal expected, @games_manager.list_of_seasons
  end

  def test_it_can_find_total_goals
    assert_equal 38, @games_manager.total_goals
  end

  def test_it_find_average_goals_per_game
    assert_equal 4.75, @games_manager.average_goals_per_game
  end

  def test_it_can_find_average_goals_by_season
    expected = {
      "20122013" => 4.86,
      "20152016" => 4.0
    }
    assert_equal expected, @games_manager.average_goals_by_season
  end

  def test_it_can_find_total_goals_by_season
    season = '20122013'
    assert_equal 34, @games_manager.total_goals_by_season(season)
  end

  def test_it_can_find_average_data_of_goals_by_season
    season = '20122013'
    assert_equal 4.86, @games_manager.average_goals_by_season_data(season)
  end

  def test_it_can_find_season_id
    game_id = '2012030221'
    assert_equal '20122013', @games_manager.find_season_id(game_id)
  end
end
