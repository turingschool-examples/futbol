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

  def test_it_can_sum_goals_per_game
    expected = {
      2014020006 => 6,
      2014021002 => 4,
      2014020598 => 3,
      2014020917 => 5,
      2014020774 => 4,
      2017020012 => 2
    }
    assert_equal expected, @stats.sum_game_goals
  end

  def test_it_can_determine_highest_and_lowest_game_score
    assert_equal 2, @stats.lowest_total_score
    assert_equal 6, @stats.highest_total_score
  end


end
