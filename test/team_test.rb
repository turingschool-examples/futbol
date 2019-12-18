require_relative 'test_helper'
require_relative '../lib/team'

class TeamTest < Minitest::Test
  def setup
    @team = Team.new({
            team_id: 1,
            franchiseId: 23,
            teamName: "Atlanta United",
            abbreviation: "ATL",
            Stadium: "Mercedes-Benz Stadium",
            link: "/api/v1/team/1"
     })
  end

  def test_a_team_exists
    assert_instance_of Team, @team
  end

  def test_a_team_has_attributes
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/team/1", @team.link
  end
end
