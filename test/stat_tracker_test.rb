require './test/test_helper'
require './lib/game'
require 'CSV'

class StatTrackerTest < Minitest::Test
  def setup
    # using top 20 rows in each csv
    game_path = './data/dummy_games.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes
    assert_equal 20, @stat_tracker.teams.count
    assert_equal 20, @stat_tracker.games.count
    assert_equal 20, @stat_tracker.game_teams.count
  end

  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end
end
