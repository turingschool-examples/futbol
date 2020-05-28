require "./lib/season_statistics"
require "minitest/autorun"
require "minitest/pride"

class SeasonStatisticsTest < MiniTest::Test

  def setup
    game_path = './season_stats_fixtures/games_fixtures.csv'
    team_path = './season_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './season_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = SeasonStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of SeasonStatistics, @stat_tracker
    assert_equal './season_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './season_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './season_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end

  def test_for_winningest_coach
    skip
    #pause

  end

  def test_by_game_by_season
    assert_equal 16, @stat_tracker.games_by_season("20142015").count
    assert_equal 0, @stat_tracker.games_by_season("20202021").count
  end

  def test_wins_per_team

  end
end
