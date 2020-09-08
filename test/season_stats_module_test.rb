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

  def test_find_all_games_from_season

    assert_equal "5/16/13", @stat_tracker.find_all_games_from_season("20122013")[0].date_time
  end

  # def test_array_of_game_id_from_season
  #
  #   assert_equal 806, @stat_tracker.array_of_game_id_from_season("20122013").length
  # end

  def test_game_teams_data_for_season

    assert_equal 1612, @stat_tracker.game_teams_data_for_season("20122013").length
  end

  def test_season_coaches

    assert_equal 34, @stat_tracker.season_coaches("20122013").length
  end

  def test_winningest_coach

    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
  end

  def test_worst_coach

    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
  end

  def test_season_teams

    assert_equal 30, @stat_tracker.season_teams("20132014").length
  end

  def test_most_accurate_team

    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
  end

  def test_least_accurate_team

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
  end

  # def test_most_tackles
  #
  #   assert_equal [], @stat_tracker.most_tackles("20122013")
  # end

end
