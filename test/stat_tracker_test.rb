require './test/test_helper'
require "minitest/autorun"
require "minitest/pride"
require "./lib/stat_tracker"

class FutbolDALTest < Minitest::Test
  def test_it_exists
    info = {
            game: "./test/fixtures/games_truncated.csv",
            team: "./test/fixtures/teams_truncated.csv",
            game_team: "./test/fixtures/game_teams_truncated.csv"
            }
    stat_tracker = StatTracker.from_csv(info)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_attributes
    info = {
            game: "./test/fixtures/games_truncated.csv",
            team: "./test/fixtures/teams_truncated.csv",
            game_team: "./test/fixtures/game_teams_truncated.csv"
            }
    stat_tracker = StatTracker.from_csv(info)

    assert_instance_of TeamCollection, stat_tracker.team_collection
    assert_instance_of GameCollection, stat_tracker.game_collection
    assert_instance_of GameTeamCollection, stat_tracker.game_team_collection
  end
end
