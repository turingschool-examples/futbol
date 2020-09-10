require './test/test_helper'
require './lib/season_stats_module'
require './lib/stat_tracker'
require 'pry'

class SeasonStatisticsTest <Minitest::Test

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

  def test_game_teams_data_for_season

    assert_equal 1612, @stat_tracker.game_teams_data_for_season("20122013").length
    assert_equal "2012030221", @stat_tracker.game_teams_data_for_season("20122013")[0].game_id
    assert_equal "Todd McLellan", @stat_tracker.game_teams_data_for_season("20122013")[-1].head_coach
  end

  def test_season_coaches
    expected_1 = ["John Tortorella", "Claude Julien", "Dan Bylsma"]
    expected_2 = ["Jon Cooper", "Martin Raymond", "Dan Lacroix"]

    assert_equal 34, @stat_tracker.season_coaches("20122013").length
    assert_equal expected_1, @stat_tracker.season_coaches("20122013")[0..2]
    assert_equal expected_2, @stat_tracker.season_coaches("20122013")[-3..-1]
  end

  def test_winningest_coach

    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
  end

  def test_worst_coach

    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
  end

  def test_season_teams
    expected = ["16", "19", "30", "21", "26", "24", "25", "23",
                "4", "17", "29", "15", "20", "18", "6", "8", "5", "2", "52",
                "14", "13", "28", "7", "10", "27", "1", "9", "22", "3", "12"]
    assert_equal 30, @stat_tracker.season_teams("20132014").length
    assert_equal expected, @stat_tracker.season_teams("20132014")
  end

  def test_most_accurate_team

    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
  end

  def test_least_accurate_team

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
  end

  def test_most_tackles

    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
  end

  def test_fewest_tackles

    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
  end

  def test_coaches_by_win_percentage

    assert_equal 34, @stat_tracker.coaches_by_win_percentage("20132014").length
    assert_equal 48.42, @stat_tracker.coaches_by_win_percentage("20132014")["Dan Bylsma"]
  end
end
