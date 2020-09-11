require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < MiniTest::Test
  def test_it_exists
    game_path = './data/games_dummy.csv'
    game_manager = GameManager.new(game_path, "tracker")

    assert_instance_of GameManager, game_manager
  end

  def test_create_underscore_games
    game_path = './data/teams_dummy.csv'
    game_manager = GameManager.new(game_path, "tracker")

    game_manager.games.each do |game|
      assert_instance_of Game, game
    end
  end
end
