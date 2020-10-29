require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team_info = {"team_id" =>"1",
                  "franchise_id" =>"23",
                  "team_name" =>"Atlanta United",
                  "abbreviation" =>"ATL",
                  "link"=> "/api/v1/teams/1"
                }
    @team = Team.new(@team_info, 'manager')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @team
    assert_equal "1", @team.team_id
    assert_equal "23", @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "/api/v1/teams/1", @team.link
  end
end
