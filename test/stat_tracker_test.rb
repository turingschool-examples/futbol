require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_stats'
require './lib/team'
require './lib/game'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test

  # locations = {
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }

  def setup
      @stat_tracker = StatTracker.from_csv({
        :teams     => "./data/teams.csv",
        :games => "./data/games.csv",
        :game_teams => "./data/game_teams.csv"
      })
    end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes

    assert_equal "./data/teams.csv", @stat_tracker.team_path
    assert_equal "./data/games.csv", @stat_tracker.game_path
    assert_equal "./data/game_teams.csv", @stat_tracker.game_teams_path

  end

  def test_it_has_teams
  expected = "Atlanta United"
    assert_equal expected, @stat_tracker.teams(@stat_tracker.team_path)[0].teamname
  end

  def test_it_has_games
    assert_equal 2012030222, @stat_tracker.games(@stat_tracker.game_path)[1].game_id
  end

  def test_it_has_game_stats
    assert_equal 2012030222, @stat_tracker.game_stats(@stat_tracker.game_teams_path)[2].game_id
  end
end
