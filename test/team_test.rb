require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require 'simplecov'
SimpleCov.start

class TeamTest < Minitest::Test
  def setup
    @test_line = "1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1".split(",")
    @team = Team.new(@test_line)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_initialize
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbr
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end
end
