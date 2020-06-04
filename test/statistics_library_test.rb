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

class StatisticsLibraryTest < MiniTest::Test
  def test_it_exists
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stats_lib = StatisticsLibray.new(info)

    assert_instance_of StatisticsLibray, stats_lib
  end
end
