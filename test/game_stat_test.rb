require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../lib/game_stat'
require 'pry'

class GameStatTest < Minitest::Test

  def setup
    game_path = './test/games_sample.csv'
    team_path = './test/teams_sample.csv'
    game_teams_path = './test/game_teams_sample.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_highest_total_score
    assert_equal 501, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 499, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 42.11, @stat_tracker.percentage_home_wins.round(2)
  end

  def test_percentage_visitor_wins
    assert_equal 52.63, @stat_tracker.percentage_visitor_wins.round(2)
  end

  def test_percentage_ties
    assert_equal 5.26, @stat_tracker.percentage_ties.round(2)
  end

  def test_count_of_games_by_season
    expected = {
      '20122013' => 10,
      '20142015' => 5,
      '20162017' => 4
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 1000, @stat_tracker.average_goals_per_game
  end
end
