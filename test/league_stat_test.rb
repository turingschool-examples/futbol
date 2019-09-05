require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../lib/league_stat'
require 'pry'

class LeagueStatTest < Minitest::Test

  def setup
    game_path = './test/games_sample.csv'
    team_path = './test/teams_sample.csv'
    game_teams_path = './test/game_teams_sample.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_count_of_teams
    assert_equal 16, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Real Salt Lake", @stat_tracker.best_offense
  end

  def test_worst_offense
  end

  def test_best_defense
  end

  def test_worst_defense
  end

  def test_highest_scoring_visitor
  end

  def test_highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
  end

  def test_winningest_team
  end

  def test_best_fans
  end

  def test_worst_fans
  end
end
