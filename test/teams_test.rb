require './test/test_helper'

class TeamTest < Minitest::Test
  def setup
    @chi_fire = Team.new({
                  team_id: 4,
                  franchiseID: 16,
                  teamName: "Chicago Fire",
                  abbreviation: "CHI",
                  stadium: "SeatGeek Stadium",
                  link: "/api/v1/teams/4"
                })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @rockets
    assert_equal 4, @rockets.team_id
    assert_equal 16, @rockets.franchiseID
    assert_equal "Chicago Fire", @rockets.teamName
    assert_equal "CHI", @rockets.abbreviation
    assert_equal "SeatGeek Stadium", @rockets.stadium
    assert_equal "/api/v1/teams/4", @rockets.link
  end
end
