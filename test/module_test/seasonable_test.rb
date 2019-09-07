require "minitest/autorun"
require "minitest/pride"
require "./lib/seasonable"
require "./lib/stat_tracker"


class SeasonableModuleTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal "string", @stat_tracker.biggest_bust
  end
  def test_biggest_bust
    assert_equal "string", @stat_tracker.biggest_bust
  end
  def test_biggest_bust
    assert_equal "string", @stat_tracker.biggest_bust
  end
  def test_biggest_bust
    assert_equal "string", @stat_tracker.biggest_bust
  end
  def test_biggest_bust
    assert_equal "string", @stat_tracker.biggest_bust
  end
