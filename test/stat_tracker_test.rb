require_relative './test_helper'
require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/collection'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_stat_tracker_exists
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_that_data_can_be_passed_to_stat_tracker_attributes
    skip
    assert_instance_of GameCollection, @stat_tracker.games_collection
    assert_instance_of TeamCollection, @stat_tracker.teams_collection
    # assert_instance_of GameCollection, @stat_tracker.games
  end

  def test_stat_tracker_average_goals_per_game
    skip
    assert_instance_of Float, @stat_tracker.average_goals_per_game
    assert_equal 4.15, @stat_tracker.average_goals_per_game
  end

  def test_stat_tracker_average_goals_by_season
    skip
    average_hash = {
      "20122013"=>3.85, 
      "20142015"=>4.02, 
      "20152016"=>4.1, 
      "20162017"=>4.36, 
      "20172018"=>4.16, 
      "20132014"=>4.27
    }

    assert_equal average_hash, @stat_tracker.average_goals_by_season
  end

  def test_highest_total_score
    skip
    assert_instance_of Integer, @stat_tracker.highest_total_score
    assert_equal 10, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    skip
    assert_instance_of Integer, @stat_tracker.lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout_method_can_look_at_game_scores
    assert_equal 8, @stat_tracker.biggest_blowout
  end

  def test_count_of_games_by_season
    count_game_hash = {
      "20122013"=>806,
      "20132014"=>1323,
      "20142015"=>1319,
      "20152016"=>1321,
      "20162017"=>1317, 
      "20172018"=>1355, 
    }
    assert_equal count_game_hash, @stat_tracker.count_of_games_by_season
  end

  def test_percentage_ties_method
    skip
    assert_instance_of Float, @stat_tracker.percentage_ties
    assert_equal 0.21, @stat_tracker.percentage_ties
  end

  def test_percentage_home_wins
    skip
    team_1_home = @stat_tracker.percentage_home_wins
    assert_instance_of Float, team_1_home
    assert_equal 0.4, team_1_home

    team_2_home = @stat_tracker.percentage_home_wins
    assert_instance_of Float, team_2_home
    assert_equal 0.4, team_2_home
  end

  def test_percentage_visitor_wins
    skip
    team_1_visitor = @stat_tracker.percentage_visitor_wins
    assert_instance_of Float, team_1_visitor
    assert_equal 0.39, team_1_visitor

    team_2_visitor = @stat_tracker.percentage_visitor_wins
    assert_instance_of Float, team_2_visitor
    assert_equal 0.39, team_2_visitor
  end
end
