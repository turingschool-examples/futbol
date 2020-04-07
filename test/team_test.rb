require './test/test_helper'
require './lib/team'

class TeamTest < MiniTest::Test

  def setup
    @team = Team.new({
      team_id: 1,
      franchiseId: 23,
      teamName: "Atlanta United"
      abbreviation: "ATL",
      Stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1"})
    Team.from_csv("./data/teams.csv")
    end

  def test_existence
    assert_instance_of Team, @team
  end

  def test_attributes
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end
    
end
