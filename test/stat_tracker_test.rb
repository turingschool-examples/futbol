require './test/test_helper'
require './lib/stat_tracker'
require 'pry'


class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_team: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)

  end


  def test_it_exists

    assert_instance_of StatTracker, @stat_tracker

  end

  def test_it_has_csv_paths
    assert_equal "./fixtures/games_fixture.csv", @stat_tracker.games
    assert_equal "./fixtures/game_teams_fixture.csv", @stat_tracker.game_team
    assert_equal "./fixtures/teams_fixture.csv", @stat_tracker.teams
  end



end
