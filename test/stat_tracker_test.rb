require './test/test_helper'
require "./lib/stat_tracker"
require "./lib/game"
require "pry"

class StatTrackerTest < MiniTest::Test

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

  def test_it_exist

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_StatTracker_can_find_highest_total_score

    assert_equal 11, @stat_tracker.highest_total_score
  end
end

# game.find {|game| game["date_time"] == "5/16/13"; return game["venue"] }
