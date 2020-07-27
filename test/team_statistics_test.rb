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

  #def test_it_has_attributes
  #end

end
