require_relative 'test_helper'

class TeamTest < Minitest::Test
  def setup
    team_path = './data/teams.csv'
    @stat_tracker ||= StatTracker.new({teams: team_path})
  end

  def test_it_exists
    team = Team.new(@stat_tracker.team_table)
    assert_instance_of Team, team
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.new
    assert_equal false, stat_tracker.team_table.include?("14")
    actual = @stat_tracker.team_table["14"]
    assert_equal "Audi Field", actual.stadium
    assert_equal "DC", actual.abbreviation
    assert_equal "31", actual.franchise_id
    assert_equal "/api/v1/teams/14", actual.link
    assert_equal "DC United", actual.team_name
    assert_equal "14", actual.team_id
  end
  
end
