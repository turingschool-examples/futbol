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

  def test_percentage_home_wins
    assert_equal 63.64, @stat_tracker.percentage_home_wins
  end

  def test_percentage_home_wins
    assert_equal 27.27, @stat_tracker.percentage_away_wins
  end

  def test_percentage_ties
    assert_equal ((1.0 / 11) * 100).round(2), @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {20122013 => 3,
                20132014 => 3,
                20172018 => 5}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

end
