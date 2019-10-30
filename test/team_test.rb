require_relative 'test_helper'
require_relative '../lib/team'

class TeamTest < Minitest::Test

  def test_it_exists
    team = Team.new({})
    assert_instance_of Team, team
  end

  def test_it_has_attributes
    team = Team.new({team_id: 1, teamname: "LA Galaxy"})

    assert_equal 1, team.team_id
    assert_equal "LA Galaxy", team.teamName
  end

end
