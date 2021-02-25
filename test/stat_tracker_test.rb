require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
# require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    skip
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
    skip
    assert_instance_of StatTracker, @stat_tracker_instance
  end

  def test_it_can_read_from_created_csv_tables
    skip
    stat = StatTracker.new(@locations)
    assert_equal "1", stat.teams[0]["team_id"]
  end
end
