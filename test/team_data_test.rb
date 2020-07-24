require "minitest/autorun"
require "minitest/pride"
require "./lib/team_data"
require "csv"
class TeamDataTest < Minitest::Test

  def test_it_exists
    team_data = TeamData.new
    assert_instance_of TeamData, team_data
  end

  def test_it_can_create_many_objects
    all_teams = TeamData.create_objects
  end

end
