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
    assert_equal "Claude Julien", @season_stats.winningest_coach
  end
end
