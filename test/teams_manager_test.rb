require './test/test_helper'
require './lib/teams_manager'


class TeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/games_dummy15.csv"
    team_manager = TeamsManager.new(path)

    assert_instance_of TeamsManager, team_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    path = "./fixture/games_dummy15.csv"
    team_manager = TeamsManager.new(path)

    assert_equal 15, team_manager.teams.length
    assert_instance_of Team, team_manager.teams[0]
    assert_instance_of Team, team_manager.teams[-1]
  end
end
