require_relative 'test_helper'
require_relative '../lib/team'

class TeamsTest < Minitest::Test
  def setup
    @team = Teams.new(
      franchiseId: 23,
      teamName: 'Atlanta United',
      abbreviation: 'ATL',
      stadium: 'Mercedes-Benz Stadium'
    )
  end

  def test_a_team_exists
    assert_instance_of Teams, @team
  end

  def test_a_team_has_attributes
    assert_equal 23, @team.franchise_id
    assert_equal 'Atlanta United', @team.team_name
    assert_equal 'ATL', @team.abbreviation
    assert_equal 'Mercedes-Benz Stadium', @team.stadium
  end
end
