require './lib/team'
require './test/test_helper'

class TeamTest < Minitest::Test
  def setup
    @team = Team.new({team_id: 1, franchiseid: 23,
      teamname: "Atlanta United", abbreviation: "ATL", stadium: "Mercedes-Benz Stadium", link: "/api/v1/teams/1"
      })
      Team.from_csv("./data/teams.csv")
      @teams = Team.all
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_readable_attributes
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end

  def test_from_csv_creates_team_objects
    assert_instance_of Team, @teams[0]
    assert_instance_of Team, @teams[-1]
    assert_equal 1, @teams[0].team_id
    assert_equal 23, @teams[0].franchise_id
    assert_equal "Atlanta United", @teams[0].team_name
    assert_equal "ATL", @teams[0].abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams[0].stadium
    assert_equal "/api/v1/teams/1", @teams[0].link
  end

  def test_it_can_create_array_of_all_teams
    assert_instance_of Array, @teams
    assert_equal 32, @teams.length
  end

  def test_it_can_find_team_name_by_team_id
    assert_equal "Chicago Fire", Team.find_name(4)
  end
end
