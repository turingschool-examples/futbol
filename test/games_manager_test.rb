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
                "20122013"=>806, "20162017"=>1317, "20142015"=>1319, "20152016"=>1321, "20132014"=>1323, "20172018"=>1355
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

  def test_best_season
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)
    game_manager.best_season('6')

    assert_equal "20132014", game_manager.best_season('6')
  end

  def test_worst_season
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal "20142015", game_manager.worst_season('6')
  end

  def test_average_win_percentage
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 0.49, game_manager.average_win_percentage('6')
  end

  def test_most_goals_scored
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 6, game_manager.most_goals_scored('6')
  end

  def test_fewest_goals_scored
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 0, game_manager.fewest_goals_scored('6')
  end

  def test_total_home_goals
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    expected = {
                "6"=>586, "3"=>557, "5"=>664, "16"=>598,
                "17"=>503, "8"=>519, "9"=>540, "30"=>556,
                "19"=>549, "26"=>546, "24"=>593, "2"=>546,
                "15"=>586, "20"=>520, "14"=>609, "28"=>579,
                "4"=>502, "21"=>523, "25"=>556, "13"=>502,
                "18"=>574, "10"=>538, "29"=>524, "52"=>553,
                "54"=>132, "1"=>456, "23"=>470, "27"=>143,
                "7"=>411, "22"=>485, "12"=>474, "53"=>317
               }
    assert_equal expected, game_manager.total_home_goals
  end

  def test_total_home_games
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    expected =  {
                "6"=>257, "3"=>265, "5"=>278, "16"=>268,
                "17"=>242, "8"=>249, "9"=>245, "30"=>250,
                "19"=>253, "26"=>255, "24"=>264, "2"=>240,
                "15"=>264, "20"=>236, "14"=>263, "28"=>258,
                "4"=>238, "21"=>236, "25"=>239, "13"=>232,
                "18"=>256, "10"=>238, "29"=>237, "52"=>240,
                "54"=>51, "1"=>231, "23"=>234, "27"=>65,
                "7"=>229, "22"=>235, "12"=>229, "53"=>164
                }

    assert_equal expected, game_manager.total_home_games
  end

  def test_highest_scoring_home_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)
    assert_equal "54", game_manager.highest_scoring_home
  end

  def test_lowest_scoring_home_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)
    assert_equal "7", game_manager.lowest_scoring_home
  end
end
