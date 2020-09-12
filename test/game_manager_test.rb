require 'minitest/autorun'
require 'minitest/pride'
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

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @game_manager.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @game_manager.lowest_total_score
  end

  def test_it_can_calculate_percentage_home_wins
   assert_equal 0.53, @game_manager.percentage_home_wins
  end
end
