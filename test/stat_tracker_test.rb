require "./test/test_helper"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @stats = StatTracker.from_csv
  end

  def test_it_is_a_stat_tracker
    assert_instance_of StatTracker, @stats
  end

  def test_it_has_access_to_other_classes
    assert_instance_of Game, @stats.games[0]
    assert_equal 6, @stats.games.count
    assert_instance_of Team, @stats.teams[0]
    assert_equal 5, @stats.teams.count
    assert_instance_of GameTeam, @stats.game_teams[0]
    assert_equal 12, @stats.game_teams.count
  end

# ~~~ HELPER METHOD TESTS~~~
  def test_it_can_find_total_games
    assert_equal 6, @stats.total_games
  end

# ~~~ GAME METHOD TESTS~~~
  def test_it_can_get_percentage_away_games_won
    assert_equal 33.33, @stats.percentage_away_wins
  end

  def test_it_can_get_percentage_ties
    assert_equal 33.33, @stats.percentage_ties
  end
  #   assert_equal 33.33, @stats.percentage_home_wins
  # end

# ~~~ LEAGUE METHOD TESTS~~~


# ~~~ SEASON METHOD TESTS~~~


# ~~~ TEAM METHOD TESTS~~~
end
