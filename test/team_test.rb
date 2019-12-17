require_relative 'test_helper'
require_relative '../lib/team'

class TeamTest < MiniTest::Test
  def setup
    @team = Team.new({team_id: 1,
                      franchiseId: 23,
                      teamName: "Atlanta United",
                      abbreviation: "ATL",
                      Stadium: "Mercedes-Benz Stadium",
                      link: "/api/v1/teams/1"})
  end

  def test_team_is_made_with_accessible_states
    assert_instance_of Team, @team
    assert_equal 1, @team.id
    assert_equal 23, @team.franchiseId
    assert_equal "Atlanta United", @team.name
    assert_equal "ATL", @team.abbr
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end

end
