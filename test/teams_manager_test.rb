require './test/test_helper'
require './lib/teams_manager'


class TeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/teams_dummy15.csv"
    team_manager = TeamsManager.new(path)

    assert_instance_of TeamsManager, team_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    path = "./fixture/teams_dummy15.csv"
    team_manager = TeamsManager.new(path)

    assert_equal 15, team_manager.teams.length
    assert_instance_of Team, team_manager.teams[0]
    assert_instance_of Team, team_manager.teams[-1]
  end


  def test_get_names_hash
    teams_manager = TeamsManager.new('./fixture/teams_dummy15.csv')

    team_hash = teams_manager.get_names_hash

    assert_equal "Atlanta United", team_hash["1"]
    assert_equal "FC Dallas", team_hash["6"]
    assert_equal "Minnesota United FC", team_hash["18"]
    assert_equal "Orlando City SC", team_hash["30"]
  end

  def test_get_name
    teams_manager = TeamsManager.new('./fixture/teams_dummy15.csv')

    assert_equal "Atlanta United", teams_manager.get_team_name("1")
    assert_equal "FC Dallas", teams_manager.get_team_name("6")
    assert_equal "Minnesota United FC", teams_manager.get_team_name("18")
    assert_equal "Orlando City SC", teams_manager.get_team_name("30")
  end

  def test_team_info
    teams_manager = TeamsManager.new('./data/teams.csv')

    expected = {team_id: "1", franchise_id: "23", team_name: "Atlanta United", abbreviation: "ATL", link: "/api/v1/teams/1"}

    assert_equal expected, teams_manager.team_info("1")
  end

end
