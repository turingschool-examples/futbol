require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require 'pry'
require 'csv'

class StatTrackerTest < Minitest::Test

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

  def test_it_exists_and_attributes
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_attributes
    assert_instance_of Hash, @stat_tracker.all_teams
    assert_instance_of Hash, @stat_tracker.all_games
    assert_equal Team, @stat_tracker.all_teams.values.first.class
    assert_equal Game, @stat_tracker.all_games.values.first.class
    assert_equal GameTeam, @stat_tracker.all_game_teams.values[0]["home"].class
    assert_equal GameTeam, @stat_tracker.all_game_teams.values[0]["away"].class
  end
end
