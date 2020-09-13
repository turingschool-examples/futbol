require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'mocha/minitest'
require 'Pry'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < MiniTest::Test
  def setup
    game_path = './data/games_dummy.csv'
    @game_manager = GameManager.new(game_path, "tracker")
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_create_underscore_games
    @game_manager.games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_game_manager_can_calculate_highest_total_score
    assert_equal 7, @game_manager.highest_total_score
  end

  def test_game_manager_can_calculate_lowest_total_score
    assert_equal 1, @game_manager.lowest_total_score
  end

  def test_game_manager_can_calculate_percentage_home_wins
   assert_equal 0.53, @game_manager.percentage_home_wins
  end

  def test_game_manager_can_calculate_percentage_visitor_wins
    assert_equal 0.41, @game_manager.percentage_visitor_wins
  end

  def test_game_manager_can_calculate_percentage_ties
    assert_equal 0.06, @game_manager.percentage_ties
  end

  def test_it_finds_highest_scoring_visitor
    @game_manager.tracker.stubs(:get_team_name).returns("FC Cincinnati")
    assert_equal "FC Cincinnati", @game_manager.highest_scoring_visitor
  end

  def test_it_finds_highest_scoring_home_team
    @game_manager.tracker.stubs(:get_team_name).returns("Chicago Fire")
    assert_equal "Chicago Fire", @game_manager.highest_scoring_home_team
  end

  def test_can_find_lowest_scoring_visitor
    @game_manager.tracker.stubs(:get_team_name).returns("Atlanta United")
    assert_equal "Atlanta United", @stat_tracker.lowest_scoring_visitor
  end

  def test_can_find_most_accurate_team
    @game_team_manager.tracker.stubs(:get_team_name).returns("Real Salt Lake")
    assert_equal "Real Salt Lake", @game_team_manager.most_accurate_team("20162017")
  end

  def test_can_find_least_accurate_team
    skip
    assert_equal "Toronto FC", @game_team_manager.least_accurate_team("20162017")
  end
end
