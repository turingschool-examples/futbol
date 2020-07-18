require './test/test_helper'
require './lib/team'
require 'pry'

class TeamTest < MiniTest::Test

  def setup
    team_param = {team_id: 1,
                  franchise_id: 23,
                  team_name: "Atlanta United",
                  abbreviation: "ATL",
                  link: "/api/v1/teams/1"}

    @team = Team.new(team_param)


  end

  def test_team_exists
    assert_instance_of Team, @team 

  end

end
