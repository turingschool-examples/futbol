require_relative './test_helper'
require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/fixtures/games_truncated.csv'
    team_path = './test/fixtures/teams_truncated.csv'
    # game_team_path = './test/fixtures/game_teams_truncated.csv'
    games = GameCollection.new(game_path)
    teams = TeamCollection.new(team_path)
    # game_team = GameTeamCollection.new(game_team_path)
    @new_tracker = StatTracker.new(games, teams)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @new_tracker
  end

  def test_that_data_can_be_passed_to_stat_tracker_attributes
    assert_instance_of GameCollection, @new_tracker.games_collection
    assert_instance_of TeamCollection, @new_tracker.teams_collection
    # assert_instance_of GameCollection, @new_tracker.games
  end

  def test_stat_tracker_average_goals_per_game
    assert_instance_of Float, @new_tracker.average_goals_per_game
    assert_equal 4.15, @new_tracker.average_goals_per_game
  end

  def test_stat_tracker_average_goals_by_season
    average_hash = {"20122013" => 4.13, "20162017" => 5, "20142015" => 5}

    assert_equal average_hash, @new_tracker.average_goals_by_season
  end

  def test_highest_total_score
    assert_instance_of Integer, @new_tracker.highest_total_score
    assert_equal 10, @new_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_instance_of Integer, @new_tracker.lowest_total_score
    assert_equal 1, @new_tracker.lowest_total_score
  end

  def test_biggest_blowout_method_can_look_at_game_scores
    assert_equal 3, @new_tracker.biggest_blowout
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>8}), @new_tracker.count_of_games_by_season
  end
end
