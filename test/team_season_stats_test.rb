require_relative 'test_helper'

class TeamSeasonStatsTest < Minitest::Test
  def setup
    @team_stats = TeamSeasonStats.new("./test/fixtures/truncated_games.csv")
  end

  def test_it_exists
    assert_instance_of TeamSeasonStats, @team_stats
  end
end
