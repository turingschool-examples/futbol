# frozen_string_literal: true

require './test/test_helper'
require './lib/game_methods'

class GameMethodsTest < Minitest::Test
  def test_it_exists
    game_methods = GameMethods.new('./test/csv_test.csv')

    assert_instance_of GameMethods, game_methods

    assert_equal './test/csv_test.csv', game_methods.file_loc
  end

  def test_generates_table
    file_loc = './test/csv_test.csv'

    game_methods = GameMethods.new(file_loc)

    expected = CSV.parse(File.read(file_loc), headers: true)

    assert_equal expected, game_methods.create_table

    assert_equal expected, game_methods.table
  end

  def test_highest_total_score
    file_loc = './data/games.csv'

    game_methods = GameMethods.new(file_loc)

    assert_equal 11, game_methods.highest_total_score
  end

  def test_lowest_total_score
    file_loc = './data/games.csv'

    game_methods = GameMethods.new(file_loc)

    assert_equal 0, game_methods.lowest_total_score
  end

  def test_average_goals_by_season
    file_loc = './data/games.csv'

    game_methods = GameMethods.new(file_loc)

    expected = {
          "20122013"=>4.12,
          "20162017"=>4.23,
          "20142015"=>4.14,
          "20152016"=>4.16,
          "20132014"=>4.19,
          "20172018"=>4.44
        }
    assert_equal expected, game_methods.average_goals_by_season
  end
end
