require_relative 'test_helper'
require 'CSV'
require './lib/stat_tracker'
require './lib/game'
require './lib/games_methods'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/team'

class StatTrackerTest < Minitest::Test
  # attr_reader :stat_tracker
  # def setup
  #   @stat_tracker = StatTracker.new
  #   stat_tracker.load_from_csv('./test/fixtures')
  # end
  def setup
    @stat_tracker = StatTracker.from_csv({
      :games     => "./data/games_truncated.csv",
      :teams => "./data/teams.csv",
      :game_teams => "./data/game_teams_truncated.csv",
    })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  # def test_it_has_attributes
  #   assert_equal "./data/games_truncated.csv", @stat_tracker.game_path
  #   assert_equal "./data/teams.csv", @stat_tracker.team_path
  #   assert_equal "./data/game_teams_truncated.csv", @stat_tracker.game_teams_path
  # end
  #
  def test_it_can_create_games
    assert_instance_of Games, @stat_tracker.games
  end

  def test_it_can_create_teams
    assert_instance_of Teams, @stat_tracker.teams
  end

  def test_it_can_create_game_teams
    assert_instance_of GameTeams, @stat_tracker.game_teams
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_total_games_per_team
    assert_equal 12, @stat_tracker.total_games_per_team(3)
  end

  def test_best_offense
    assert_equal "Toronto FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Atlanta United", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "LA Galaxy", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "New England Revolution", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Orlando City SC", @stat_tracker.lowest_scoring_home_team
  end

end
