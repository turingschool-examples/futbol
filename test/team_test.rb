require './test/test_helper'

class TeamTest < Minitest::Test
  def setup
    @chi_fire = Team.new({
                  team_id: 4,
                  franchiseid: 16,
                  teamname: "Chicago Fire",
                  abbreviation: "CHI",
                  stadium: "SeatGeek Stadium",
                  link: "/api/v1/teams/4"
                })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @chi_fire
    assert_equal 4, @chi_fire.team_id
    assert_equal 16, @chi_fire.franchiseid
    assert_equal "Chicago Fire", @chi_fire.teamname
    assert_equal "CHI", @chi_fire.abbreviation
    assert_equal "SeatGeek Stadium", @chi_fire.stadium
    assert_equal "/api/v1/teams/4", @chi_fire.link
  end
end
