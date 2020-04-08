require './test/test_helper'
require './lib/stat_tracker'


class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_has_attributes
    assert_instance_of Game, @stat_tracker.games.first
    assert_instance_of Team, @stat_tracker.teams.first
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
  end

  def test_it_can_return_sum_of_games_goals
    assert_equal 45, @stat_tracker.sum_of_goals
  end

  def test_it_can_find_average_goals
    assert_equal 3.63 , @stat_tracker.average_goals_per_game
  end
end
