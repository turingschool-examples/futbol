require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team = Team.new
  end

  def test_it_exists
    skip
    assert_instance_of Team, @team
  end

end
