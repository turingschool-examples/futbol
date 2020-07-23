#require "./test/test_helper"
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/stat_tracker"
require "./lib/games"
require "./lib/game_teams"
require "./lib/teams"
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

  def test_find_the_fewest_tackles
    #skip
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

    def test_find_the_most_tackles
      skip
      assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
      assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("“20142015")
    end





end
