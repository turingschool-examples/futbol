require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/team'

class TeamManagerTest < MiniTest::Test
  def test_it_exists
    team_path = './data/teams_dummy.csv'
    team_manager = TeamManager.new

    assert_instance_of TeamManager, team_manager
  end
end
