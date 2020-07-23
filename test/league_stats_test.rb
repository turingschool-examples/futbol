require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/league_stats'
require 'pry'

class LeagueStatsTest < MiniTest::Test
  def setup
    data = {
      games:      './fixtures/games_fixture.csv',
      teams:      './fixtures/teams_fixture.csv',
      game_teams: './fixtures/game_teams_fixture.csv'
    }

    @league_stats = LeagueStats.new(data)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_an_count_number_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_best_offense
    assert_equal "New York City FC", @league_stats.best_offense
  end

  def test_worst_offense
    assert_equal "Sporting Kansas City", @league_stats.worst_offense
  end

  def test_can_get_highest_scoring_visitor
    assert_equal "FC Dallas", @league_stats.highest_scoring_visitor
  end

  def test_losest_scoring_visitor
    assert_equal "Sporting Kansas City", @league_stats.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "New York City FC", @league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @league_stats.lowest_scoring_home_team
  end

end
