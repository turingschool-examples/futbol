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
            games:      './fixtures/games_fixture.csv',
            teams:      './fixtures/teams_fixture.csv',
            game_teams: './fixtures/game_teams_fixture.csv'
            }

    @team_stats = TeamStats.new(data)
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_can_get_team_info
    expected = {"team_id"=>"17",
                "franchise_id"=>"12",
                "team_name"=>"LA Galaxy",
                "abbreviation"=>"LA",
                "link"=>"/api/v1/teams/17"}

    assert_equal expected, @team_stats.team_info("17")
  end

  def test_it_can_get_best_season
    assert_equal "20122013", @team_stats.best_season("6")
  end

  def test_it_can_get_worst_season
    assert_equal "20122013", @team_stats.worst_season("6")
  end

  def test_it_can_get_average_win_percentage
    assert_equal 1.0, @team_stats.average_win_percentage("6")
  end

  def test_it_can_most_goals_scored
    assert_equal 3, @team_stats.most_goals_scored("17")
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("17")
  end

  def test_it_can_get_favorite_opponent
    assert_equal "New England Revolution", @team_stats.favorite_opponent("17")
  end

  def test_it_can_get_rival
    assert_equal "Real Salt Lake", @team_stats.rival("17")
  end
end
