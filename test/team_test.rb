require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/team"

class TeamTest < Minitest::Test

  def setup
    @test = Team.new({:team_id => 1, :franchiseId => 23, :teamName => "Atlanta United", :abbreviation => "ATL", :Stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
  end

  def test_it_exists
    test = Team.new({:team_id => 1, :franchiseId => 23, :teamName => "Atlanta United", :abbreviation => "ATL", :Stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
    assert_instance_of Team, test
  end

  def test_it_has_attributes
    test = Team.new({:team_id => 1, :franchiseId => 23, :teamName => "Atlanta United", :abbreviation => "ATL", :Stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
    assert_equal 1, test.team_id
  end

end
