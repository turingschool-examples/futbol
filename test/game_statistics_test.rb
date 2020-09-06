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

    @stat_tracker_location = StatTracker.from_csv(locations)
    @stat_tracker = @stat_tracker_location.game_stats
    @game_statistics = GameStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_it_has_attributes
    assert_equal 7441, @game_statistics.game_id.length
  end
end
