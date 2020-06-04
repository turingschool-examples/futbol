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

class StatisticsLibrayTest < MiniTest::Test
  def test_it_exists
    stats_lib = StatisticsLibray.new(game_file, team_file, game_teams_file)

    assert_instance_of StatisticsLibray, stats_lib
  end
end
