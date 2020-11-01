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
    assert_instance_of Array, @gamestats.sum_of_scores
    @gamestats.stubs(:sum_of_scores).returns([5,8,29])
    assert_equal [5,8,29], @gamestats.sum_of_scores
  end

  def test_it_calls_highest_total_score
    assert_instance_of Integer, @gamestats.highest_total_score
    @gamestats.stubs(:highest_total_score).returns(5)
    assert_equal 5, @gamestats.highest_total_score
  end

  def test_it_calls_lowest_total_score
    assert_instance_of Integer, @gamestats.lowest_total_score
    @gamestats.stubs(:lowest_total_score).returns(5)
    assert_equal 5, @gamestats.lowest_total_score
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    assert_instance_of Float, @gamestats.percentage_home_wins
    @gamestats.stubs(:percentage_home_wins).returns(45.23)
    assert_equal 45.23, @gamestats.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_away_team_win
    assert_instance_of Float, @gamestats.percentage_away_wins
    @gamestats.stubs(:percentage_away_wins).returns(45.23)
    assert_equal 45.23, @gamestats.percentage_away_wins
  end

  def test_it_calls_percentage_of_games_tied
    assert_instance_of Float, @gamestats.percentage_ties
    @gamestats.stubs(:percentage_ties).returns(11.55)
    assert_equal 11.55, @gamestats.percentage_ties
  end

  def test_total_percentages_equals_100
    assert_equal 100, (@gamestats.percentage_home_wins +
                       @gamestats.percentage_away_wins +
                       @gamestats.percentage_ties)
  end
  
end
