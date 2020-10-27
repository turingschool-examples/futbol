require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/team_manager'

class TeamManagerTest < Minitest::Test

  def setup
    @team_manager = TeamManager.new('./data/teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamManager, @team_manager
    assert_equal './data/teams.csv', @team_manager.teams_data
  end

  def test_it_gives_array_of_all_teams
    assert_equal Team,  @team_manager.all.first.class
  end



end
