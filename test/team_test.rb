require "./test/test_helper"
require "./lib/team"

class TeamTest < Minitest::Test
  def setup
    Team.from_csv
  end

  def test_it_can_read_from_CSV
    assert_equal 5, Team.all_teams.count
  end

  def test_it_can_have_attributes
    team1 = Team.all_teams[0]

    assert_equal 1, team1.team_id
    assert_equal 23, team1.franchise_id
    assert_equal "Atlanta United", team1.team_name
    assert_equal "ATL", team1.abbreviation
    assert_equal "Mercedes-Benz Stadium", team1.stadium
    assert_equal "/api/v1/teams/1", team1.link
  end
end
