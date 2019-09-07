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
    game_path = './test/test_data/games_sample_2.csv'
    team_path = './test/test_data/teams_sample.csv'
    game_teams_path = './test/test_data/game_teams_sample_2.csv'

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
    assert_equal "Seattle Sounders FC", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "FC Dallas", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Seattle Sounders FC", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "LA Galaxy", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Philadelphia Union", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Los Angeles FC",
                  "New England Revolution",
                  "LA Galaxy",
                  "Atlanta United",
                  "DC United"], @stat_tracker.worst_fans
  end
end
