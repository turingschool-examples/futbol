require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require 'mocha/minitest'

class TeamTest < Minitest::Test

  def setup
    @sample_data = '1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1'
    @team = Team.new(@sample_data)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
  
end
