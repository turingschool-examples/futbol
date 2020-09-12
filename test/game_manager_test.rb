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
end
