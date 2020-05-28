require "./lib/team_statistics"
require "minitest/autorun"
require "minitest/pride"

class TeamStatisticsTest < MiniTest::Test

  def setup
    game_path = './team_stats_fixtures/games_fixtures.csv'
    team_path = './team_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './team_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = TeamStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of TeamStatistics, @stat_tracker
    assert_equal './team_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './team_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './team_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end
end
