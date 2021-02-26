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

  def test_percentage_home_wins_dummy_file
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)

    assert_equal Float, game_manager.percentage_home_wins.class
    assert_equal 0.67, game_manager.percentage_home_wins
  end

  def test_percentage_visitor_wins_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal Float, game_manager.percentage_visitor_wins.class
    assert_equal 0.36, game_manager.percentage_visitor_wins
  end

  def test_percentage_ties_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal Float, game_manager.percentage_ties.class
    assert_equal 0.2, game_manager.percentage_ties
  end

  def test_count_of_games_by_season_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)
    
    expected = {
      "20122013"=>806, "20162017"=>1317, "20142015"=>1319, 
      "20152016"=>1321, "20132014"=>1323, "20172018"=>1355
    }
    
    assert_equal Hash, game_manager.count_of_games_by_season.class
    assert_equal expected, game_manager.count_of_games_by_season
  end
  
  def test_average_goals_per_game
    path = "./fixture/games_dummy15.csv"
    game_manager = GamesManager.new(path)
    
    assert_equal Float, game_manager.average_goals_per_game.class
    assert_equal 3.6, game_manager.average_goals_per_game
  end

  def test_average_goals_by_season
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)
    game_manager.count_of_games_by_season

    expected = {
                "20122013"=>4.12, "20162017"=>4.23, 
                "20142015"=>4.14, "20152016"=>4.16, 
                "20132014"=>4.19, "20172018"=>4.44
                }
    assert_equal Hash, game_manager.average_goals_by_season.class
    assert_equal expected, game_manager.average_goals_by_season
  end
end
