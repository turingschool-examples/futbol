require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def test_it_exists
    fake_data = {team_id: "1", franchiseid: "23", teamname: "Atlanta United", abbreviation: "ATL", stadium:"Mercedes-Benz Stadium", link: "/api/v1/teams/1"}

    team = Team.new(fake_data)

    assert_instance_of Team, team
  end

  def test_it_has_attributes
    fake_data = {team_id: "1", franchiseid: "23", teamname: "Atlanta United", abbreviation: "ATL", stadium:"Mercedes-Benz Stadium", link: "/api/v1/teams/1"}

    team = Team.new(fake_data)

    assert_equal "1", team.team_id
    # assert_equal "23", team.franchise_id
    assert_equal "Atlanta United", team.team_name
    # assert_equal "ATL", team.abbreviation
    # assert_equal "Mercedes-Benz Stadium", team.stadium
    # assert_equal "/api/v1/teams/1", team.link
  end

  def test_get_names_hash
    teams_manager = TeamsManager.new('./fixture/game_teams_dummy15.csv')

    team_hash = teams_manager.get_names_hash

    assert_equal "Atlanta United", team_hash["1"]
    assert_equal "FC Dallas", team_hash["6"]
    assert_equal "Minnesota United", team_hash["18"]
    assert_equal "Orlando City", team_hash["30"]
  end

  def test_get_name
    teams_manager = TeamsManager.new('./fixture/game_teams_dummy15.csv')

    assert_equal "Atlanta United", teams_manager.get_name("1")
    assert_equal "FC Dallas", teams_manager.get_name("6")
    assert_equal "Minnesota United", teams_manager.get_name("18")
    assert_equal "Orlando City", teams_manager.get_name("30")
  end
end
