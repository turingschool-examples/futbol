require_relative 'test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @atlanta = {
      team_id: "1",
      franchiseId: "23",
      teamName: "Atlanta United",
      abbreviation: "ATL",
      Stadium: "Mercedes-Benz Stadium",
      link: ".api/v1/teams/1"
    }
  end

  def test_it_exists
    team = Team.new(@atlanta)

    assert_instance_of Team, team
  end

end
