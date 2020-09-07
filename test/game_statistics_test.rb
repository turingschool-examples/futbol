require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'

class GameStatisticsTest < Minitest::Test
  #Data Used:
  #Game: game_id, season, home_goals, away_goals
  #Game_Team: HoA, result, team_id
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker_location = StatTracker.from_csv(locations)
    @stat_tracker = @stat_tracker_location.game_stats
    @stat_game_teams_tracker = @stat_tracker_location.game_teams_stats
    @game_statistics = GameStatistics.new(@stat_tracker, @stat_game_teams_tracker)
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_it_has_attributes
    assert_equal 7441, @game_statistics.game_data.length
  end

  def test_it_can_get_all_scores_by_game_id
    assert_equal 7441, @game_statistics.get_all_scores_by_game_id.length
  end

  def test_it_can_find_highest_total_score
    assert_equal 11, @game_statistics.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 0, @game_statistics.lowest_total_score
  end

  def test_knows_all_home_wins
    assert_equal 3237, @game_statistics.all_home_wins.length
  end

  def test_it_knows_percentage_home_wins
    assert_equal 0.44, @game_statistics.percentage_home_wins
  end

  def test_it_knows_all_visitor_wins
    assert_equal 2687, @game_statistics.all_visitor_wins.length
  end

  def test_it_knows_percentage_visitor_wins
    assert_equal 0.36, @game_statistics.percentage_visitor_wins
  end

end
