# frozen_string_literal: true

require './test/test_helper'
require './lib/team_methods'

class TeamMethodsTest < Minitest::Test
  def test_it_exists
    team_methods = TeamMethods.new('./test/csv_test.csv')

    assert_instance_of TeamMethods, team_methods

    assert_equal './test/csv_test.csv', team_methods.file_loc
  end

  def test_generates_table
    file_loc = './test/csv_test.csv'

    game_methods = GameMethods.new(file_loc)

    expected = CSV.parse(File.read(file_loc), headers: true)

    assert_equal expected, game_methods.create_table

    assert_equal expected, game_methods.table
  end
end
