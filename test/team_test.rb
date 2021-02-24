require './test/test_helper'

class TeamTest < Minitest::Test
  def setup
    @rockets = Team.new({
                  team_id: 7,
                  franchiseID: 777,
                  teamName: "Rockets",
                  abbreviation: "DET",
                  stadium: "Detroit Hall",
                  link: "/api/v1/teams/177"
                })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @rockets
    assert_equal 7, @rockets.team_id
    assert_equal 777, @rockets.franchiseID
    assert_equal "Rockets", @rockets.teamName
    assert_equal "DET", @rockets.abbreviation
    assert_equal "Detroit Hall", @rockets.stadium
    assert_equal "/api/v1/teams/177", @rockets.link
  end
end
