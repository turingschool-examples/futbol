require_relative './test_helper'
require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/season'
require './lib/collection'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'
require './lib/season_collection'

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
    stat_tracker = mock('StatTracker')
    stat_tracker.stubs(:klass).returns('StatTracker')

    assert_equal 'StatTracker', stat_tracker.klass
  end

  def test_that_collections_are_the_correct_class_type
    stat_tracker = mock('StatTracker')
    stat_tracker.stubs(:klass).returns('KlassType')

    assert_equal 'KlassType', stat_tracker.klass

    stat_tracker.stubs(:games_collection).returns('GamesCollection')
    assert_equal 'GamesCollection', stat_tracker.games_collection

    stat_tracker.stubs(:teams_collection).returns('TeamsCollection')
    assert_equal 'TeamsCollection', stat_tracker.teams_collection

    stat_tracker.stubs(:game_teams_collection).returns('GameTeamsCollection')
    assert_equal 'GameTeamsCollection', stat_tracker.game_teams_collection
  end

  def test_stat_tracker_average_goals_per_game
    assert_instance_of Float, @stat_tracker.average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_stat_tracker_average_goals_by_season
    average_hash = {
      '20122013'=>4.12,
      '20132014'=>4.19,
      '20142015'=>4.14,
      '20152016'=>4.16,
      '20162017'=>4.23,
      '20172018'=>4.44
    }

    assert_equal average_hash, @stat_tracker.average_goals_by_season
  end

  def test_highest_total_score
    assert_instance_of Integer, @stat_tracker.highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_instance_of Integer, @stat_tracker.lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout_method_can_look_at_game_scores
    stat_tracker = mock('StatTracker')
    stat_tracker.stubs(:biggest_blowout).returns(8)
    assert_equal 8, stat_tracker.biggest_blowout
  end

  def test_count_of_games_by_season
    stat_tracker = mock('StatTracker')
    stat_tracker.stubs(:count_of_games_by_season).returns({
      '20122013'=>806,
      '20132014'=>1323,
      '20142015'=>1319,
      '20152016'=>1321,
      '20162017'=>1317,
      '20172018'=>1355
    })
    assert_equal 1355, stat_tracker.count_of_games_by_season['20172018']
  end

  def test_percentage_ties_method
    assert_instance_of Float, @stat_tracker.percentage_ties
    assert_equal 0.2, @stat_tracker.percentage_ties
  end

  def test_percentage_home_wins
    team_1_home = @stat_tracker.percentage_home_wins
    assert_instance_of Float, team_1_home
    assert_equal 0.44, team_1_home
  end

  def test_percentage_visitor_wins
    team_1_visitor = @stat_tracker.percentage_visitor_wins
    assert_instance_of Float, team_1_visitor
    assert_equal 0.36, team_1_visitor
  end
end
