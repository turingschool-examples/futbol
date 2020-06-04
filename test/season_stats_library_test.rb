require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/statistics_library'
require './lib/season_statistics_library'

class SeasonStatisticsTest < MiniTest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @season_stats = SeasonStatisticsLibrary.new(@info)
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @season_stats.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @season_stats.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @season_stats.worst_coach("20132014")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @season_stats.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @season_stats.most_tackles("20142015")
  end

  def test_fewest_tackles
    assert_equal "Atlanta United", @season_stats.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @season_stats.fewest_tackles("20142015")
  end

  def test_most_accurate_team
    assert_equal "Real Salt Lake", @season_stats.most_accurate_team("20132014")
    assert_equal "Toronto FC", @season_stats.most_accurate_team("20142015")
  end
end
