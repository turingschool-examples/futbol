require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/games_methods'

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
      :game_teams => "./data/game_teams.csv",
    })
  end

  def test_it_exists
    # stat_tracker = StatTracker.new
    # assert_instance_of StatTracker, stat_tracker
    assert_instance_of StatTracker, @stat_tracker
  end
  def test_it_has_attributes
    assert_equal "./data/games_truncated.csv", @stat_tracker.game_path
    assert_equal "./data/teams.csv", @stat_tracker.team_path
    assert_equal "./data/game_teams.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_create_games
    assert_instance_of Games, @stat_tracker.games
  end

  def test_it_can_create_teams
    assert_instance_of Teams, @stat_tracker.teams
    #need teams class
  end
########
  # def test_count_of_teams
  #   assert_equal 5, stat_tracker.count_of_teams
  # end
  #
  # def test_total_games_per_team
  #   assert_equal 5, stat_tracker.total_games_per_team(3)
  # end
  #
  # def test_best_offense
  #   assert_equal "FC Dallas", stat_tracker.best_offense
  # end
end
