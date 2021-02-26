require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
# require './test/test_helper'
require './lib/games_manager'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './dummy_data/games_dummy.csv'
    @team_path = './dummy_data/teams_dummy.csv'
    @game_teams_path = './dummy_data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker_method = StatTracker.from_csv(@locations)
    @stat_tracker_instance = StatTracker.new(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker_instance
  end

end
