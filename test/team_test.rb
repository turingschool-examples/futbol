require_relative 'test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team = Team.new({
          team_id: 1,
          franchiseId: 23,
          teamName: "Atlanta United"
        })
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_attributes
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchiseId
    assert_equal "Atlanta United", @team.teamName
  end


end
