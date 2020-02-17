require_relative 'test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @atlanta = {
      team_id: "1",
      franchise_id: "23",
      team_name: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium",
      link: ".api/v1/teams/1"
    }
    @team = Team.new(@atlanta)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_details
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal ".api/v1/teams/1", @team.link
  end
end
