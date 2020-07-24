require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/team_data"
require 'csv'

class LeagueStatisticTest < Minitest::Test

  def test_it_exists
    @league_statistics = LeagueStatistics.new
    assert_instance_of LeagueStatistics, @league_statistics
  end

  #def test_it_has_attributes
  #end

end
