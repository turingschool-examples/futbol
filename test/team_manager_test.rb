require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/team'
require './lib/team_manager'

class TeamManagerTest < MiniTest::Test
  def setup
    team_path = './data/teams_dummy.csv'
    @team_manager = TeamManager.new(team_path, "tracker")

  end
  def test_it_exists
    assert_instance_of TeamManager, @team_manager
  end

  def test_create_underscore_teams
    @team_manager.teams.each do |team|
      assert_instance_of Team, team
    end
  end

  def test_it_can_count_teams
    assert_equal 13, @team_manager.count_of_teams
  end

  def test_it_can_get_team_info
    expected = {
                "team_id" => "24",
                "franchise_id" => "32",
                "team_name" => "Real Salt Lake",
                "abbreviation" => "RSL",
                "link" => "/api/v1/teams/24"
    }
    assert_equal expected, @team_manager.team_info("24")
  end

  def test_it_can_find_best_team_name
  assert_equal "Real Salt Lake", @team_manager.get_team_name("24")
  end
end
