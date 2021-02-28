require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_team_tables'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'
require './lib/helper_modules/csv_to_hashable'

class GameTeamTableTest < Minitest::Test
  include CsvToHash
  def setup
    stat_tracker = StatTracker.new()
    locations = './data/game_teams.csv'
    @game_table = GameTeamTable.new(locations, stat_tracker)
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
end
