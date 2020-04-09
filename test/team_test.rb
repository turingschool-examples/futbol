require './lib/game'
require 'pry'

class TeamTest < Minitest::Test

  def setup
    @team = Team.new(args)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_readable_attributes
    assert_equal 1, @team.id
    assert_equal 23, @team.franchise_id
    assert_equal "Atlanta United", @team.team_name
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end
end






# team_id,franchiseId,teamName,abbreviation,Stadium,link
# 1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1
