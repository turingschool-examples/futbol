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
            games:      './fixtures/games_fixture.csv',
            teams:      './fixtures/teams_fixture.csv',
            game_teams: './fixtures/game_teams_fixture.csv'
            }

    @season_stats = SeasonStats.new(data)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_cognizant_of_winningest_coach
    assert_equal "Claude Julien", @season_stats.winningest_coach("20122013")
  end

  def test_it_can_get_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end

  def test_it_can_get_most_accurate_team
    assert_equal "New York City FC", @season_stats.most_accurate_team("20122013")
  end

  def test_it_can_get_least_accurate_team
    assert_equal "Sporting Kansas City", @season_stats.least_accurate_team("20122013")
  end

  def test_it_can_get_most_tackles
    assert_equal "LA Galaxy", @season_stats.most_tackles("20122013")
  end

  def test_it_knows_fewest_tackles
    assert_equal "Sporting Kansas City", @season_stats.fewest_tackles("20122013")
  end
end
