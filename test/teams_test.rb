require_relative '../lib/teams'
require_relative 'test_helper'

class TeamTest < Minitest::Test

  def setup
    @line_2 = Team.new("1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1")
  end

  def test_it_exists
    assert_instance_of Team, @line_2
  end


  def test_attributes
    assert_equal 1, @line_2.team_id
    assert_equal 23, @line_2.franchiseId
    assert_equal "Atlanta United", @line_2.teamName
    assert_equal "ATL", @line_2.abbreviation
    assert_equal "Mercedes-Benz Stadium", @line_2.stadium
    assert_equal "/api/v1/teams/1", @line_2.link
  end

end
