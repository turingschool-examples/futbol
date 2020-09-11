require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/team'
require './lib/team_manager'

class TeamManagerTest < MiniTest::Test
  def test_it_exists
    team_path = './data/teams_dummy.csv'
    team_manager = TeamManager.new(team_path, "tracker")

    assert_instance_of TeamManager, team_manager
  end

  def test_create_underscore_teams
    team_path = './data/teams_dummy.csv'
    team_manager = TeamManager.new(team_path, "tracker")

    team_manager.teams.each do |team|
      assert_instance_of Team, team
    end
  end
end
