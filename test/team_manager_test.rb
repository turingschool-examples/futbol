require './test/test_helper'

class TeamManagerTest < Minitest::Test
  def setup
    @team_data = TeamManager.new('data/teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_data
  end

  def test_count_of_teams
    assert_equal 32, @team_data.count_of_teams
  end

  def test_team_info
    expected = {
                  "team_id" => 14,
                  "franchiseid" => 31,
                  "teamname" => "DC United",
                  "abbreviation" => "DC",
                  "link" => "/api/v1/teams/14"
                }
    assert_equal expected, @team_data.team_info(14)
  end
end
