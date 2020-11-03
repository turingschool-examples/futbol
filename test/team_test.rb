require_relative './test_helper'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    row = {:team_id=>"1",
             :franchiseid=>"23",
             :teamname=>"Atlanta United",
             :abbreviation=>"ATL",
             :stadium=>"Mercedes-Benz Stadium",
             :link=>"/api/v1/teams/1"
            }
    @team = Team.new(row)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @team
    assert_equal "1", @team.team_id
    assert_equal "23", @team.franchiseid
    assert_equal "Atlanta United", @team.teamname
    assert_equal "ATL", @team.abbreviation
  end

  def test_team_info
    expected = {"team_id"=>"1",
                "franchise_id"=>"23",
                "team_name"=>"Atlanta United",
                "abbreviation"=>"ATL",
                "link"=>"/api/v1/teams/1"
              }
    assert_equal expected, @team.team_info
  end
end
