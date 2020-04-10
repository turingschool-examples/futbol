require_relative 'test_helper'

class TeamStatsTest < Minitest::Test
  def setup
    @team_stats = TeamStats.new("./test/fixtures/truncated_game_teams.csv")
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_can_find_all_games_for
    assert_equal 3, @team_stats.all_games_for(17).count
    assert_equal 4, @team_stats.all_games_for(5).count
  end
end
