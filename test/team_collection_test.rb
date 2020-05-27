require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'
require './lib/team'


class TeamCollectionTest < Minitest::Test
  def setup
    @team_collection = TeamCollection.new("./fixtures/teams_fixture.csv")

  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_can_collect_teams
    assert_instance_of Team, @team_collection.all.first
    assert_equal 6, @team_collection.all.count
  end
end
