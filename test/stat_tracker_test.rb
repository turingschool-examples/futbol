require_relative 'test_helper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({games: './data/dummy_game.csv', teams: './data/dummy_team.csv', game_teams: './data/dummy_game_team.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal './data/dummy_game.csv', @stat_tracker.game_path
    assert_equal './data/dummy_team.csv', @stat_tracker.team_path
    assert_equal './data/dummy_game_team.csv', @stat_tracker.game_teams_path
  end

  def test_it_creates_an_array_of_all_objects
    assert_instance_of Array, @stat_tracker.game_teams
    assert_instance_of GameTeam, @stat_tracker.game_teams[0]
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams[0]
  end

  def test_it_can_pull_all_teams_with_the_worst_fans
    skip
    assert_equal [], @stat_tracker.worst_fans
  end
end
