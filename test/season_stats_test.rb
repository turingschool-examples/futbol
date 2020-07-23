require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/game_stats'
require './lib/season_stats'

class SeasonStatsTest < Minitest::Test

  def setup
    data = {
            games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'
            }

    @season_stats = SeasonStats.new(data)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_cognizant_of_winningest_coach
    assert_equal "Alain Vigneault", @season_stats.winningest_coach("20142015")
    assert_equal "Claude Julien", @season_stats.winningest_coach("20132014")
  end

  def test_it_can_get_worst_coach
    assert_equal "Peter Laviolette", @season_stats.worst_coach("20132014")
  end

  def test_it_can_get_most_accurate_team

    assert_equal "Real Salt Lake", @season_stats.most_accurate_team("20132014")
  end

  def test_it_can_get_least_accurate_team

    assert_equal "New York City FC", @season_stats.least_accurate_team("20132014")
  end

  def test_it_can_get_most_tackles
    assert_equal "FC Cincinnati", @season_stats.most_tackles("20132014")
  end

  def test_it_knows_fewest_tackles
    assert_equal "Atlanta United", @season_stats.fewest_tackles("20132014")
  end

end
