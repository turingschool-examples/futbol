

require './test/test_helper'
require './lib/team_methods'

class TeamMethodsTest < Minitest::Test
  def test_it_exists
    team_methods = TeamMethods.new('./test/csv_test.csv')
  end

  def test_generates_table
  file_loc = './test/csv_test.csv'

  team_methods = TeamMethods.new('./test/csv_test.csv')

  expected = CSV.parse(File.read(file_loc), headers: true)

  assert_equal expected, team_methods.create_table

  assert_equal expected, team_methods.table
  end

  def test_team_info
    file_loc = './test/csv_test.csv'

    team_methods = TeamMethods.new('./test/csv_test.csv')

    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_equal expected, team_methods.team_info
  end
end
