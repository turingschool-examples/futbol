require_relative 'test_helper'
require "./lib/game_statistics"
require 'mocha/minitest'


class GameStatisticsTest < Minitest::Test
  #Data Used:
  #Game: game_id, season, home_goals, away_goals
  #Game_Team: HoA, result, team_id
  def setup
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

end
