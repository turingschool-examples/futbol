require_relative 'test_helper'
require './lib/scored_goal_stat'

class ScoredGoalStatTest < Minitest::Test

  def setup
    team_file_path = './data/teams.csv'
    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    game_file_path = './test/fixtures/truncated_games.csv'
    @scored_goal_stat = ScoredGoalStat.new(team_file_path, game_team_file_path, game_file_path)
  end

  def test_it_exists
    assert_instance_of ScoredGoalStat, @scored_goal_stat
  end

  def test_it_can_return_most_goals_scored
    assert_equal 5, @scored_goal_stat.most_goals_scored("3")
  end

  def test_it_can_return_fewest_goals_scored
    assert_equal 0, @scored_goal_stat.fewest_goals_scored("3")
  end

  def test_it_can_return_total_goals
    assert_instance_of Array, @scored_goal_stat.total_goals_scored("3")
    assert_equal 28, @scored_goal_stat.total_goals_scored("3").length
    assert_equal 2, @scored_goal_stat.total_goals_scored("3").first
  end
end