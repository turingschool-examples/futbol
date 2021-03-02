require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_team_tables'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'
require './lib/helper_modules/csv_to_hashable'

class GameTeamTableTest < Minitest::Test
  include CsvToHash
  include ReturnTeamable
  def setup
    stat_tracker = StatTracker.new
    locations = './data/game_teams.csv'
    @game_table = GameTeamTable.new(locations, stat_tracker)
    require 'pry'; binding.pry
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @game_table.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @game_table.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @game_table.worst_coach("20132014")
    assert_equal "Craig MacTavish" || "Ted Nolan", @game_table.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Real Salt Lake", @game_table.most_accurate_team("20132014")
    assert_equal "Toronto FC", @game_table.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    assert_equal "New York City FC", @game_table.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @game_table.least_accurate_team("20142015")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @game_table.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @game_table..most_tackles("20142015")
  end

  def test_fewest_tackles
    assert_equal "Atlanta United", @game_table.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @game_table.fewest_tackles("20142015")
  end

  def test_best_offense

    assert_equal "Reign FC", @game_table.best_offense
  end

  def test_highest_scoring_visitor

    assert_equal "FC Dallas", @game_table.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @game_table.lowest_scoring_visitor
  end

  def test_average_win_percentage
    assert_equal 0.49, @game_table.average_win_percentage("6")
  end

  def test_best_season
    assert_equal "20132014", @game_table.best_season("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @game_table.fewest_goals_scored("18")
  end
end
