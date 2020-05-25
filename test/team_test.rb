require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    team_params = {team_id: "1",
                  franchise_id: "23",
                    team_name: "Atlanta United",
                    abbreviation: "ATL",
                    link: "/api/v1/teams/1"}
    @team = Team.new(team_params)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
