require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team = Team.new
  end

  def test_it_exists

    assert_instance_of Team, @team
  end

end
