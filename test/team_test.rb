require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @team = Team.new ({
      "abbreviation"=>"ATL",
      "franchise_id"=>23,
      "link"=>"/api/v1/teams/1",
      "stadium"=>"Mercedes-Benz Stadium",
      "team_id"=>1,
      "team_name"=>"Atlanta United",
    })
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
