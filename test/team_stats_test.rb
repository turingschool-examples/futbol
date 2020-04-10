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

  def test_can_get_most_goals_by_team_id
    assert_equal 3, @team_stats.most_goals_scored(17)
    assert_equal 1, @team_stats.most_goals_scored(5)
    assert_equal 4, @team_stats.most_goals_scored(6)
  end

  def test_can_find_fewest_goals_by_team_id
    assert_equal 1, @team_stats.fewest_goals_scored(17)
    assert_equal 0, @team_stats.fewest_goals_scored(5)
    assert_equal 1, @team_stats.fewest_goals_scored(6)
  end

  def test_can_calculate_average_win_percentage
    assert_equal 66.67, @team_stats.average_win_percentage(17)
  end
end
