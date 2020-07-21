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
    # skip
    assert_equal "Sporting Kansas City", @stat_tracker.highest_scoring_visitor

  end

  def test_it_can_create_visiting_teams_hash
    assert_equal 7441, @stat_tracker.game_id_and_visiting_teams.count
    assert_equal Hash, @stat_tracker.game_id_and_visiting_teams.class

    assert_equal "16", @stat_tracker.game_id_and_visiting_teams["2012030236"]
  end

end
