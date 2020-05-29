require'./test/test_helper'
require'./lib/stat_tracker'
require'csv'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/game_teams_fixture.csv"})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes

    assert_instance_of Game, @stat_tracker.games[0]
    assert Array, @stat_tracker.games
    assert_instance_of Team, @stat_tracker.teams[0]
    assert Array, @stat_tracker.teams
    assert_instance_of GameTeam, @stat_tracker.game_teams[0]
    assert Array, @stat_tracker.game_teams
  end

  # def test_it_can_count_teams
  #   assert_equal 32, @stat_tracker.count_of_teams
  # end

  def test_percentage_ties_is_found
    assert_equal 43.75, @stat_tracker.percentage_ties
  end
end
