require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/gamestats'

class GameStatsTest < Minitest::Test

  def setup
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  @gamestats = GameStats.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of GameStats, @gamestats
  end

  def test_sum_of_scores
    mock_sum_of_scores = mock("sum_of_scores")
    assert_equal  mock_sum_of_scores, @stat_tracker.sum_of_scores
    assert_instance_of Array, @stat_tracker.sum_of_scores
    @stat_tracker.stubs(sum_of_scores).returns([5,8,29])
    assert_equal [5,8,29], @stat_tracker.sum_of_scores
  end

  # def test_it_calls_highest_total_score
  #   mock_high_score = mock("high_score")
  #   assert_equal  mock_high_score, @stat_tracker.highest_total_score
  #   assert_instance_of Integer, @stat_tracker.highest_total_score
  #   @stat_tracker.stubs(highest_total_score).returns(5)
  #   assert_equal 5, @stat_tracker.highest_total_score
  # end

end
