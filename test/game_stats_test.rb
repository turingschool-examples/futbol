require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/game_stats'

class GameStatsTest < Minitest::Test

  def setup
    data = {
      games:      './fixtures/games_fixture.csv',
      teams:      './fixtures/teams_fixture.csv',
      game_teams: './fixtures/game_teams_fixture.csv'
    }
    @game_stats = GameStats.new(data)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_get_highest_total_score
    assert_equal 5, @game_stats.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_it_can_get_percentage_home_wins
    assert_equal 0.68, @game_stats.percentage_home_wins
  end

  def test_it_can_get_percentage_visitor_wins
    assert_equal 0.3, @game_stats.percentage_visitor_wins
  end

  def test_it_can_get_percentage_ties
    assert_equal 0.03, @game_stats.percentage_ties
  end

  def test_it_can_get_count_of_games_by_season
    expected = {"20122013"=>37}
    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_it_can_get_average_goals_per_game
    assert_equal 3.81, @game_stats.average_goals_per_game
  end

  def test_it_can_get_average_goals_by_season
    expected = {"20122013"=>3.81}
    assert_equal expected, @game_stats.average_goals_by_season
  end
end
