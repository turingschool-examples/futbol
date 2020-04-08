require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_statistics'
require 'pry'

class GameStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @game_statistics = GameStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_has_readable_attributes
    # assert_equal @stat_tracker, @game_statistics.stat_tracker
    assert_equal'./data/games_fixture.csv', @game_statistics.stat_tracker.games
    assert_equal'./data/teams_fixture.csv', @game_statistics.stat_tracker.teams
    assert_equal'./data/game_teams_fixture.csv', @game_statistics.stat_tracker.game_teams
  end



  def test_highest_total_score
    assert_equal 5, @game_statistics.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1,  @game_statistics.lowest_total_score
  end

  def test_it_can_calculate_percentage_of_home_wins
    assert_equal 50.00, @game_statistics.percentage_home_wins
  end

  def test_it_can_calculate_percentage_of_visitor_game_wins
    assert_equal 40.00, @game_statistics.percentage_visitor_wins
  end

  def test_it_can_calculate_percenatage_ties
    assert_equal 0, @game_statistics.percentage_ties
  end

end
