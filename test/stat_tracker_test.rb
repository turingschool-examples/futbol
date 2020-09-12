require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @games_path = './data/games.csv'
    @teams_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    locations = {
      games: @games_path,
      teams: @teams_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_attributes
    assert_equal @games_path, @stat_tracker.games_path
    assert_equal @teams_path, @stat_tracker.teams_path
    assert_equal @game_teams_path, @stat_tracker.game_teams_path
  end

  def test_from_csv
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    mock_game_methods = mock
    mock_game_methods.stubs(:highest_total_score).returns(8, nil)
    @stat_tracker.game_methods = mock_game_methods

    assert_equal 8, @stat_tracker.highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_best_offense_team
    assert_equal 'Reign FC', @stat_tracker.best_offense
  end

  def test_worst_offense_team
    assert_equal 'Utah Royals FC', @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor_team
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor_team
  end

  def test_lowest_scoring_visitor_team
    assert_equal 'San Jose Earthquakes', @stat_tracker.lowest_scoring_visitor_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Utah Royals FC', @stat_tracker.lowest_scoring_home_team
  end

  def test_highest_scoring_home_team
    assert_equal 'Reign FC', @stat_tracker.highest_scoring_home_team
  end
end
