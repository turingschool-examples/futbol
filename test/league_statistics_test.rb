require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/team_data"
require "./lib/game_team_data"
require 'csv'

class LeagueStatisticTest < Minitest::Test

  def setup
    @league_statistics = LeagueStatistics.new
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_can_count_teams
    assert_equal 19, @league_statistics.count_of_teams
  end

  def test_find_best_and_worst_offense
    assert_equal "FC Dallas", @league_statistics.best_offense
    assert_equal "Sporting Kansas City", @league_statistics.worst_offense 
  end

end
