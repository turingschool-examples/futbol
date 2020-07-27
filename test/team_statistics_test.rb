require "minitest/autorun"
require "minitest/pride"
require "./lib/team_statistics"

class TeamStatisticsTest < Minitest::Test

  def setup
    @team_stats = TeamStatistics.new
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_stats
  end

  def test_it_can_create_team_hash_details
    expected = {:team_id=>3, :franchise_id=>10, :team_name=>"Houston Dynamo", :abbreviation=>"HOU", :link=>"/api/v1/teams/3"}
    assert_equal expected, @team_stats.team_info("3")
  end

end
