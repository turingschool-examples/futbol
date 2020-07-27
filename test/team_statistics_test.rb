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
    assert_equal [], @team_stats.team_info("3")
  end

end
