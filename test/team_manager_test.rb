require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/team'
require_relative '../lib/team_manager'

class TeamManagerTest < Minitest::Test

  def setup
    @team_manager = TeamManager.new('./data/teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamManager, @team_manager
    assert_equal './data/teams.csv', @team_manager.teams_data
  end

end
