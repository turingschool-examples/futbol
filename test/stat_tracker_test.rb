require_relative '../test_helper'
require "minitest/autorun"
require 'minitest/pride'
require './lib/stat_tracker'

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

  def test_class_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal './data/games.csv', @stat_tracker.game_path
    assert_equal './data/teams.csv', @stat_tracker.team_path
    assert_equal './data/game_teams.csv', @stat_tracker.game_teams_path
  end
end
