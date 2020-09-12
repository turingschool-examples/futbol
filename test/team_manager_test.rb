require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team_manager'
require './lib/team'
require 'pry';
require 'mocha/minitest'

class TeamManagerTest < Minitest::Test
  def setup
    tracker = mock('stat_tracker')
    teams_path = './data/teams.csv'
    @team_manager = TeamsManager.new(teams_path, tracker)
  end

  def test_it_can_count_teams
    assert_equal 32, @team_manager.count_of_teams
  end

  def test_it_can_find_a_name
    team_number = '23'
    assert_equal 'Montreal Impact', @team_manager.find_team_name(team_number)
  end
end
