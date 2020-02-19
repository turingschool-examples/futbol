require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test

  def test_it_exists
    info = {team_id: "6", franchiseId: "6", teamName: "FC Dallas",
            abbreviation: "DAL", Stadium: "Toyota Stadium", link: "/api/v1/teams/6"}
    team = Team.new(info)
    
    assert_instance_of Team, team
  end

  def test_it_has_attributes
    info = {team_id: "6", franchiseId: "6", teamName: "FC Dallas",
            abbreviation: "DAL", Stadium: "Toyota Stadium", link: "/api/v1/teams/6"}
    team = Team.new(info)

    assert_equal 6, team.team_id
    assert_equal 6, team.franchise_id
    assert_equal "FC Dallas", team.team_name
    assert_equal "DAL", team.abbreviation
    assert_equal "Toyota Stadium", team.stadium
    assert_equal "/api/v1/teams/6", team.team_link
  end
end
