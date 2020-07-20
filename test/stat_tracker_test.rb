require './test/test_helper'


class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exist
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_StatTracker_can_find_highest_total_score
    skip
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_highest_scoring_visitor
    assert_equal "", @stat_tracker.highest_scoring_visitor

  end

end
