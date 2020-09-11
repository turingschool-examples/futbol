require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/team'

class TeamTest < Minitest::Test
  def test_it_exists
    team = Team.new
    assert_instance_of Team, team
  end

  
end
