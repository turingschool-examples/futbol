require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require 'mocha/minitest'

class TeamTest < Minitest::Test

  def setup
    @sample_data = '1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1'
    # @sample_data = mock('CSV Row')
    # @sample_data.stubs(:team_id).returns(1)
    # @sample_data.expects(:team_id).returns(1)
    # @sample_data.stubs(:team_id).returns('1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1')
    # @sample_data.expects(:team_id).returns('1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1')

    @team = Team.new(@sample_data)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_initialization
    skip
    assert_equal 1, @team.team_id
    assert_equal '23', @team.franchiseId
    assert_equal 'Atlanta United', @team.teamName
    assert_equal 'ATL', @team.abbreviation
    assert_equal 'Mercedes-Benz Stadium', @team.stadium
  end

end
