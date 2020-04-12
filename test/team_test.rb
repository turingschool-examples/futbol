require './test/test_helper'
require './lib/team'

class TeamTest < MiniTest::Test

  def setup
    @team = Team.new({
      team_id: "1",
      franchiseid: "23",
      teamname: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1"})
    Team.from_csv("./data/teams.csv")
    @csv_team = Team.all[-1]
  end

  def test_existence
    assert_instance_of Team, @team
  end

  def test_attributes
    assert_equal "1", @team.team_id
    assert_equal "23", @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end

  def test_csv_access
    assert_equal "53", @csv_team.team_id
    assert_equal "28", @csv_team.franchise_id
    assert_equal "Columbus Crew SC", @csv_team.team_name
    assert_equal "CCS", @csv_team.abbreviation
    assert_equal "Mapfre Stadium", @csv_team.stadium
    assert_equal "/api/v1/teams/53", @csv_team.link
  end

end
