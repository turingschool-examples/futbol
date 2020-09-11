require './test/test_helper'
require './lib/stat_tracker'
require 'pry'



class TestStatTracker <Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.new(@locations)
  end

  def test_stat_tracker_can_pull_file_locations

    assert_equal 7441, @stat_tracker.game_manager.games.length
    assert_equal 32, @stat_tracker.team_manager.teams.length
    assert_equal 14882, @stat_tracker.game_teams_manager.game_teams.length
  end

  def test_it_has_data

    assert_equal "20122013", @stat_tracker.game_manager.games[5].season
    assert_equal "Columbus Crew SC", @stat_tracker.team_manager.teams[31].team_name
    assert_equal 41.5, @stat_tracker.game_teams_manager.game_teams[14028].faceOffWinPercentage
  end
end
