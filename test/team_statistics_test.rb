require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_statistics'

class TeamStatisticsTest < Minitest::Test

  def setup
    @team_statistics = TeamStatistics.new("./test/fixtures/teams_truncated.csv")
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end
end
