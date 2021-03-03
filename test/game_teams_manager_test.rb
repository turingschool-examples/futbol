require './test/test_helper'
require './lib/game_teams_manager'
require 'CSV'

class GameTeamsManagerTest < Minitest::Test

  def test_it_exists
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    assert_instance_of GameTeamsManager, game_team_manager
  end

  def test_it_has_attributes
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    assert_equal 15, game_team_manager.game_teams.length
    assert_instance_of GameTeam, game_team_manager.game_teams[0]
    assert_instance_of GameTeam, game_team_manager.game_teams[-1]
  end

  def test_readable_generate_list
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    assert_equal Array, game_team_manager.game_teams.class
  end

  def test_mathable_get_percentage
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    numerator = 1
    denominator = 4

    assert_equal 0.25, game_team_manager.get_percentage(numerator, denominator)
  end

  def test_mathable_sum_values
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    key_value_arr = [[1, 1], [1, 3], [1, 5], [2, 2], [2, 1]]
    expected = {1 => 9, 2 => 3}

    assert_equal expected, game_team_manager.sum_values(key_value_arr)
  end

  def test_get_team_tackle_hash
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]
    test = game_team_manager.get_team_tackle_hash(game_ids)

    assert_instance_of Hash, test
    assert_equal 77, test["3"]
    assert_equal 87, test["6"]
  end

  def test_score_shots_by_team
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal [4, 17], game_team_manager.score_and_shots_by_team(game_ids)["3"]
    assert_equal [6, 20], game_team_manager.score_and_shots_by_team(game_ids)["6"]
  end

  def test_create_ratio_hash
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    test_hash = {9 => [3, 6], 11 => [1, 4], 13 => [2, 6]}
    expected = {9 => 0.5, 11 => 0.25, 13 => 0.33}

    assert_equal expected, game_team_manager.create_ratio_hash(test_hash)
  end

  def test_winningest_coach
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal "Claude Julien", game_team_manager.winningest_coach(game_ids)
  end

  def test_worst_coach
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal "John Tortorella", game_team_manager.worst_coach(game_ids)
  end

  def test_best_offense_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal "6", game_teams_manager.best_offense
  end

  def test_worst_offense_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal "5", game_teams_manager.worst_offense
  end

  def test_favorite_opponent
    path = "./data/game_teams.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_instance_of String, game_teams_manager.favorite_opponent("6")
  end

  def test_rival
    path = "./data/game_teams.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_instance_of String, game_teams_manager.rival("6")
  end

  def test_create_goals_hash
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    expected = {"3"=>[8, 5], "6"=>[21, 7], "5"=>[2, 3]}

    assert_equal expected, game_teams_manager.create_goals_hash
  end
end
