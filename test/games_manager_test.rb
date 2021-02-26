require './test/test_helper'
require './lib/games_manager'
require 'CSV'

class GameManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_instance_of GamesManager, game_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    # start_tracker = mock
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_equal 15, game_manager.games.length
    assert_instance_of Game, game_manager.games[0]
    assert_instance_of Game, game_manager.games[-1]
  end

  def test_highest_total_score_dummy_file
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_equal 5, game_manager.highest_total_score
  end

  def test_lowest_total_score_dummy_file
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_equal 1, game_manager.lowest_total_score
  end


























  def test_get_season_games
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    season_games = game_manager.get_season_games("20122013")

    assert_equal 15, season_games.length
    assert_instance_of String, season_games[0]
    assert_instance_of String, season_games[-1]
  end


end
