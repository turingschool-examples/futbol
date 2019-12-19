require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
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

  def test_percentage_home_visitor_wins_method
    team_1_home = @new_tracker.percentage_home_visitor_wins("home")
    assert_instance_of Float, team_1_home
    assert_equal 0.5, team_1_home

    team_1_visitor = @new_tracker.percentage_home_visitor_wins("visitor")
    assert_instance_of Float, team_1_visitor
    assert_equal 0.5, team_1_visitor

    team_2_home = @new_tracker.percentage_home_visitor_wins("home")
    assert_instance_of Float, team_2_home
    assert_equal 0.5, team_2_home

    team_2_visitor = @new_tracker.percentage_home_visitor_wins("visitor")
    assert_instance_of Float, team_2_visitor
    assert_equal 0.5, team_2_visitor
  end
end
