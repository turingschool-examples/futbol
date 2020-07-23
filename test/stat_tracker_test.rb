# require "./test/test_helper.rb"
require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_best_offense_team
    assert_equal "Reign FC", @stat_tracker.best_offense

  end

  def test_it_can_worst_offense_team
    skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_can_get_highest_scoring_vistor_team
    skip
    assert_equal "FC Dallas", @stat_tracker.highest_visitor_team
  end

  def test_it_can_get_highest_scoring_home_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_home_team
  end

  def test_it_can_get_lowest_scoring_visitor_team
    skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_visitor_team
  end

  def test_it_can_get_lowest_scoring_home_team
    skip
    assert_equal "Utah Royals FC", @stat_tracker.lowest_home_team
  end
end
