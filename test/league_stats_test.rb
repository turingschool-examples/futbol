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
      games:      './data/games.csv',
      teams:      './data/teams.csv',
      game_teams: './data/game_teams.csv'
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
    # skip
    assert_equal "Reign FC", @league_stats.best_offense
  end
end
