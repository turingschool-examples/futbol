require "./test/test_helper"
require_relative "../lib/team"

class TeamTest

  def setup
    @team = Team.new({
      team_id: 1,
      franchiseId: 23,
      teamName: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1"
      })
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
