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
require './lib/league_stats_library'

class LeagueStatsLibraryTest < MiniTest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @league_stats = LeagueStatsLibrary.new(@info)
  end

  def test_it_exists
    assert_instance_of LeagueStatsLibrary, @league_stats
  end
end
