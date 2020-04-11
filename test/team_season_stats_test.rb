require_relative 'test_helper'

class TeamStatsTest < Minitest::Test
  def setup
    @team_stats = TeamStats.new('./test/fixtures/truncated_games.csv')
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end
end
