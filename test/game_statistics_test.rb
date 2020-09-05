require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'
require 'mocha/minitest'


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
    data = {:game_id => [], :season => [], :type => [], :date_time => [], :away_team_id => [], :home_team_id => [], :away_goals => [], :home_goals => []}
    @stat_tracker = StatTracker.from_csv(locations)
    @game_statistics = GameStatistics.new(@stat_tracker.game_stats(data))
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_it_has_stats
    assert_equal "2012030221", @game_statistics.game_id[0]
    assert_equal "20122013", @game_statistics.season[0]
    assert_equal "Postseason", @game_statistics.type[0]
    assert_equal "5/16/13", @game_statistics.date_time[0]
    assert_equal "3", @game_statistics.away_team_id[0]
    assert_equal "6", @game_statistics.home_team_id[0]
    assert_equal 2, @game_statistics.away_goals[0]
    assert_equal 3, @game_statistics.home_goals[0]
  end
end
