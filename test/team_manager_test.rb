require './test/test_helper'
require './lib/team'
require './lib/team_manager'

class TeamManagerTest < Minitest::Test
  def setup
    @team_manager = TeamManager.new('./data/teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamManager, @team_manager
    assert_equal Array, @team_manager.teams.class
  end

  def test_it_gives_array_of_all_teams
    assert_equal Team,  @team_manager.teams.first.class
  end

  def test_count_of_teams
    assert_equal 32, @team_manager.count_of_teams
  end

  def test_team_name
    assert_equal "Atlanta United", @team_manager.team_name("1")
  end

  def test_team_info
    expected = {
                "team_id" => "1",
                "franchise_id" => "23",
                "team_name" => "Atlanta United",
                "abbreviation" => "ATL",
                "link" => "/api/v1/teams/1"
              }
    assert_equal expected, @team_manager.team_info("1")
  end
end
