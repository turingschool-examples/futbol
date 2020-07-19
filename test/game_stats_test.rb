require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/game_stats'

class GameStatsTest < Minitest::Test

  def setup
    data = {
      games:      './data/games.csv',
      teams:      './data/games.csv',
      game_teams: './data/game_teams.csv'
    }

    @game_stats = GameStats.new(data)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_get_highest_total_score
    assert_equal 11, @game_stats.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    skip

  end

  def test_it_can_get_percentage_home_wins
    skip

  end

  def test_it_can_get_percentage_visitor_wins
    skip

  end

  def test_it_can_get_percentage_ties
    skip

  end

  def test_it_can_get_count_of_games_by_season
    skip

  end

  def test_it_can_get_average_goals_per_game
    skip

  end

  def test_it_can_get_average_goals_by_season
    skip

  end

end
