require './test/test_helper'
require './lib/game_teams_manager'
require 'CSV'


class GameTeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_instance_of GameTeamsManager, game_teams_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal 15, game_teams_manager.game_teams.length
    assert_instance_of GameTeam, game_teams_manager.game_teams[0]
    assert_instance_of GameTeam, game_teams_manager.game_teams[-1]
  end

  def test_team_id_highest_average_goals_all_full_file
    skip
    path = "./data/game_teams.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal "54", game_teams_manager.team_id_highest_average_goals_all
  end

  def test_total_goals_by_team_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    expected = {"3"=>8, "6"=>21, "5"=>2}
    
    assert_equal expected, game_teams_manager.total_goals_by_team
  end
end
