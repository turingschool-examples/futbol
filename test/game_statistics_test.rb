require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'
require 'mocha/minitest'


class GameStatisticsTest < Minitest::Test
  #Data Used:
  #Game: game_id, season, home_goals, away_goals
  #Game_Team: HoA, result, team_id
  def setup
    @game_statistics = GameStatistics.new({
      game_id: "2012030221",
      season: "20122013",
      type: "Postseason",
      date_time: "5/16/13",
      away_team_id: "3",
      home_team_id: "6",
      away_goals: 2,
      home_goals: 3
      })
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

  def test_it_can_find_highest_total_score

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    game1 = mock("game 1")
    game2 = mock("game 2")
    game3 = mock("game 3")

    game1.stubs(:home_goals).returns(5)
    game1.stubs(:away_goals).returns(3)

    game2.stubs(:home_goals).returns(6)
    game2.stubs(:away_goals).returns(1)

    game3.stubs(:home_goals).returns(3)
    game3.stubs(:away_goals).returns(3)

    stat_tracker.stubs(:games).returns([game1, game2, game3])
  #
  #   # games = GameStatistics.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals)
  #
     @game_statistics.game_total_score
  end

end
