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
end
