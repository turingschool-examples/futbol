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

  def test_most_goals_scored_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 6, game_manager.most_goals_scored('6')
  end

  def test_fewest_goals_scored_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 0, game_manager.fewest_goals_scored('6')
  end

  def test_total_away_goals
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    expected = {
                 "3"=>572, "6"=>568, "5"=>598, "17"=>504,
                 "16"=>558, "9"=>498, "8"=>500, "30"=>506,
                 "26"=>519, "19"=>519, "24"=>553, "2"=>507,
                 "15"=>582, "20"=>458, "14"=>550, "28"=>549,
                 "4"=>470, "21"=>450, "25"=>505, "13"=>453,
                 "18"=>527, "10"=>469, "29"=>505, "52"=>488,
                 "54"=>107, "1"=>440, "12"=>462, "23"=>453,
                 "22"=>479, "7"=>430, "27"=>120, "53"=>303
               }
    assert_equal expected, game_manager.total_away_goals
  end

  def test_total_away_games
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    expected =  {
                  "3"=>266, "6"=>253, "5"=>274, "17"=>247,
                  "16"=>266, "9"=>248, "8"=>249, "30"=>252,
                  "26"=>256, "19"=>254, "24"=>258, "2"=>242,
                  "15"=>264, "20"=>237, "14"=>259, "28"=>258,
                  "4"=>239, "21"=>235, "25"=>238, "13"=>232,
                  "18"=>257, "10"=>240, "29"=>238, "52"=>239,
                  "54"=>51, "1"=>232, "12"=>229, "23"=>234,
                  "22"=>236, "7"=>229, "27"=>65, "53"=>164
                }

    assert_equal expected, game_manager.total_away_games
  end

  def test_highest_scoring_visitor_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal "6", game_manager.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor_full_file
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal "27", game_manager.lowest_scoring_visitor
  end
end
