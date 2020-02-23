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

  def test_it_can_return_biggest_team_blowout
    assert_equal 4, @scored_goal_stat.biggest_team_blowout("3")
  end

  def test_it_can_return_worst_loss
    assert_equal 3, @scored_goal_stat.worst_loss("3")
  end

  def test_it_can_return_favorite_opponent
    assert_equal "North Carolina Courage", @scored_goal_stat.favorite_opponent("3")
  end

  def test_it_can_return_rival
    assert_equal "Portland Thorns FC", @scored_goal_stat.rival("3")
  end
end