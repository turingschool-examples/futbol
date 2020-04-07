require_relative 'test_helper'

class TeamTest < Minitest::Test
  def setup
    team_info = {
      :team_id => "1",
      :franchiseId => "23",
      :teamName => "Atlanta United",
      :abbreviation => "ATL",
      :Stadium => "Mercedes-Benz Stadium",
      :link => "/api/v1/teams/1"
    }
    @team = Team.new(team_info)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
