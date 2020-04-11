require_relative 'test_helper'

class TeamSeasonStatsTest < Minitest::Test
  def setup
    @team_stats = TeamSeasonStats.new("./test/fixtures/truncated_games.csv")
  end

  def test_it_exists
    assert_instance_of TeamSeasonStats, @team_stats
  end

  def test_can_find_games
    assert_equal 29, @team_stats.all_games_for(17).count
  end
end
