require "minitest/autorun"
require "minitest/pride"
require "./lib/teams"

class TeamsTest < MiniTest::Test

	def setup
    teams_params = {
      :team_id => "1",
      :teamname => "Atlanta United",
      :abbreviation => "ATL"
    }
    @teams = Teams.new(teams_params)
	end

	def test_it_exists
		assert_instance_of Teams, @teams
	end

	def test_it_has_attributes
    assert_equal "1", @teams.team_id
    assert_equal "Atlanta United", @teams.teamname
    assert_equal "ATL", @teams.abbreviation
	end

end
