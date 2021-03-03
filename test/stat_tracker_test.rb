require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = 'data/fixture/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = 'data/fixture/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Houston Dynamo", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "FC Dallas", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "FC Dallas", @stat_tracker.worst_defense
  end
end
