require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_table'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'
require './lib/helper_modules/csv_to_hashable'

class GameTableTest < Minitest::Test
include CsvToHash
  def setup
    locations = './data/games.csv'
    @game_table = GameTable.new(locations)
  end

  def test_it_exists
    assert_instance_of GameTable, @game_table
  end

  def test_highest_total_score

    assert_equal 11, @game_table.highest_total_score
  end
end
