require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test

  def test_it_exists
    atlanta = Teams.new({
      team_id: "1",
      franchiseid: "23",
      teamname: "Atlanta United",
      abbreviation: "ATL",
      link: "/api/v1/teams/1"
    })

    assert_instance_of Teams, atlanta
  end

end
