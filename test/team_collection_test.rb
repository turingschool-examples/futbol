require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/team_collection"

class TeamCollectionTest < Minitest::Test
  def setup
    @teams = TeamCollection.new('./test/data/teams.csv')
  end

  def test_it_exist
    assert_instance_of TeamCollection, @teams
  end

  def test_game_collection_can_fetch_data
    assert_equal 32, @teams.all.count
    assert_instance_of Team, @teams.all.first
  end
end
