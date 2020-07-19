require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @atlanta = Teams.new({
      team_id: "1",
      franchiseid: "23",
      teamname: "Atlanta United",
      abbreviation: "ATL",
      link: "/api/v1/teams/1"
    })
  end

  def test_it_exists
    assert_instance_of Team, @atlanta
  end

  def test_it_has_attributes


  end

end
