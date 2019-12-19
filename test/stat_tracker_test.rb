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

  def test_percentage_home_wins
    team_1 = @new_tracker.percentage_home_wins("3")
    assert_instance_of Float, team_1
    assert_equal 0.0, team_1

    team_2 = @new_tracker.percentage_home_wins("6")
    assert_instance_of Float, team_2
    assert_equal 1.0, team_2
  end


end
