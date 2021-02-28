require './test/test_helper'

class TeamManagerTest < Minitest::Test
  def setup
    @team_data = TeamManager.new('./data/teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_data
  end
end
