require_relative 'test_helper'

class TeamTest < Minitest::Test
  def setup
    @hash = {
       team_id: '1',
       franchiseid: '23',
       teamname: 'Atlanta United',
       abbreviation: 'ATL',
       link: '/api/v1/teams/1'
      }
    @team = Team.new(@hash)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_attributes
    assert_equal '1', @team.team_id
    assert_equal '23', @team.franchiseid
    assert_equal 'ATL', @team.abbreviation
    assert_equal 'Atlanta United', @team.teamname
    assert_equal '/api/v1/teams/1', @team.link
  end
end