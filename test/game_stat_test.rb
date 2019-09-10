require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../module/game_stat'
require 'pry'

class GameStatTest < Minitest::Test

  def setup
    game_path = './test/test_data/games_sample_2.csv'
    team_path = './test/test_data/teams_sample.csv'
    game_teams_path = './test/test_data/game_teams_sample_2.csv'

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
    assert_equal 0.53, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.35, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.13, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>27,
                "20142015"=>6,
                "20162017"=>4,
                "20152016"=>2,
                "20132014"=>1
              }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 16.28, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {"20122013"=>22.04,
                "20142015"=>4.0,
                "20162017"=>4.75,
                "20152016"=>4.0,
                "20132014"=>5.0
              }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
