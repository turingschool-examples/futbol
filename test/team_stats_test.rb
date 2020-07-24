require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/game_stats'
require './lib/season_stats'
require './lib/team_stats'
require 'pry'

class TeamStatsTest < Minitest::Test

  def setup
    data = {
            games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'
            }

    @team_stats = TeamStats.new(data)
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_can_get_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }
    assert_equal expected, @team_stats.team_info("18")
  end

  def test_it_can_get_best_season
    assert_equal "20132014", @team_stats.best_season("6")
  end

  def test_it_can_get_worst_season
    assert_equal "20142015", @team_stats.worst_season("6")
  end

  def test_it_can_get_average_win_percentage
    assert_equal 0.49, @team_stats.average_win_percentage("6")
  end

  def test_it_can_most_goals_scored
    assert_equal 7, @team_stats.most_goals_scored("18")
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("18")
  end

  def test_it_can_get_favorite_opponent
    assert_equal "DC United", @team_stats.favorite_opponent("18")
  end

  def test_it_can_get_rival
    skip
    assert_equal "Houston Dash", @team_stats.rival("18")
    assert_equal "LA Galaxy", @team_stats.rival("18")
  end
end
