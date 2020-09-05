require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'
require 'mocha/minitest'


class GameStatisticsTest < Minitest::Test
  #Data Used:
  #Game: game_id, season, home_goals, away_goals
  #Game_Team: HoA, result, team_id
  def setup
    @game_statistics = GameStatistics.new("2012030221", "20122013", "Postseason", "5/16/13", "3", "6", 2, 3)
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_it_has_stats
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal "2012030221", @game_statistics.game_id
    assert_equal "20122013", @game_statistics.season
    assert_equal "Postseason", @game_statistics.type
    assert_equal "5/16/13", @game_statistics.date_time
    assert_equal "3", @game_statistics.away_team_id
    assert_equal "6", @game_statistics.home_team_id
    assert_equal 2, @game_statistics.away_goals
    assert_equal 3, @game_statistics.home_goals
    
  end
  # def test_it_can_find_highest_total_score
  #
  # end

end
