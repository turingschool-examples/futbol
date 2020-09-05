require "./test/test_helper"
require "./lib/teams"

class TeamsTest < Minitest::Test
  def setup
    Teams.from_csv
  end

  def test_it_can_read_from_CSV
    assert_equal 5, Teams.all_teams.count
  end
end
