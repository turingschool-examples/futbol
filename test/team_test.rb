require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    team_data = {team_id: 1,
                franchiseId: 23,
                teamName: "Atlanta United",
                abbreviation: "ATL",
                stadium: "Mercedes_Benz Stadium",
                link: "/api/v1/teams/1"
              }
    @team = Team.new(team_data)
  end

  def test_its_values
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchiseId
    assert_equal "Atlanta United", @team.teamName
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes_Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end
end
