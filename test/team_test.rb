require_relative 'test_helper'

class TeamTest < Minitest::Test

  def setup
    @team_hash = {
                  team_id: 1,
                  franchise_id: 23,
                  team_name: 'Atlanta United',
                  abbreviation: 'ATL',
                  stadium: 'Mercedes-Benz Stadium',
                  link: '/api/v1/teams/1'
                }

    @team_1 = Team.new(@team_hash)
  end

  def test_it_exists
    assert_instance_of Team, @team_1
  end

# assert_equal true, @instructor.preference
  def test_it_initializes_with_attributes
    assert_equal 1, @team_1.team_id
    assert_equal 23, @team_1.franchise_id
    assert_equal 'Atlanta United', @team_1.team_name
    assert_equal 'ATL', @team_1.abbreviation
    assert_equal 'Mercedes-Benz Stadium', @team_1.stadium
    assert_equal '/api/v1/teams/1', @team_1.link
  end
end
