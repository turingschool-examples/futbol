require_relative 'test_helper'
require 'CSV'
require './lib/stat_tracker'
require './lib/game'
require './lib/games_methods'
require './lib/game_teams'
require './lib/teams'
require './lib/team'

class StatTrackerTest < Minitest::Test
  # attr_reader :stat_tracker
  # def setup
  #   @stat_tracker = StatTracker.new
  #   stat_tracker.load_from_csv('./test/fixtures')
  # end
  def setup
    @stat_tracker = StatTracker.from_csv({
      :games     => "./data/games_truncated.csv",
      :teams => "./data/teams.csv",
      :game_teams => "./data/game_teams_truncated.csv",
    })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end
  def test_it_has_attributes
    assert_equal "./data/games_truncated.csv", @stat_tracker.game_path
    assert_equal "./data/teams.csv", @stat_tracker.team_path
    assert_equal "./data/game_teams_truncated.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_create_games
    assert_instance_of Games, @stat_tracker.games
  end

  def test_it_can_create_teams
    assert_instance_of Teams, @stat_tracker.teams
  end

  def test_it_can_create_game_teams
    assert_instance_of GameTeams, @stat_tracker.game_teams
  end

end
