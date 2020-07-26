require "minitest/autorun"
require "minitest/pride"
require "./lib/season_statistics"
require "./lib/team_data"
require "./lib/game_data"
require "./lib/game_team_data"
require 'csv'

class SeasonStatisticsTest < Minitest::Test

  def setup
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  #def test_it_has_attributes
  #end

end
