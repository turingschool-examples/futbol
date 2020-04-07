require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_stats'
require './lib/team'
require './lib/game'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test



  def setup
      @stat_tracker = StatTracker.from_csv({
        :team     => "./data/teams.csv",
        :game => "./data/games.csv",
        :stats => "./data/game_teams.csv"
      })
    end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal "./data/teams.csv",@stat_tracker.team_path
    assert_equal "./data/games.csv", @stat_tracker.game_path
    assert_equal "./data/game_teams.csv", @stat_tracker.stat_path

  end

  def test_it_has_teams
  expected = "Atlanta United"
    assert_equal expected, @stat_tracker.teams(@stat_tracker.team_path)[0].teamname
  end

  def test_it_has_games
    assert_equal 2012030222, @stat_tracker.games(@stat_tracker.game_path)[1].game_id
  end

  def test_it_has_game_stats
    assert_equal 2012030222, @stat_tracker.game_stats(@stat_tracker.stat_path)[2].game_id
  end
end
