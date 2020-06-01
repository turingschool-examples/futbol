require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    #<CSV::Row "team_id":"1" "franchiseId":"23" "teamName":"Atlanta United" "abbreviation":"ATL" "Stadium":"Mercedes-Benz Stadium" "link":"/api/v1/teams/1">
    @team_1 = Team.new({
      :team_id => 1,
      :franchiseid => 23,
      :teamname => "Atlanta United",
      :abbreviation => "ATL",
      :link => "/api/v1/teams/1"
      })
  end

  def test_it_exists
    assert_instance_of Team, @team_1
  end

  def test_it_has_attributes
    assert_equal 1, @team_1.team_id
    assert_equal 23, @team_1.franchise_id
    assert_equal "Atlanta United", @team_1.team_name
    assert_equal "ATL", @team_1.abbreviation
    assert_equal "/api/v1/teams/1", @team_1.link
  end
end
