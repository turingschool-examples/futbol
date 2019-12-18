require_relative './test_helper'
require 'csv'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def setup
    @collection = TeamCollection.new('./test/fixtures/teams_truncated.csv')
    @team = @collection.teams.first
  end
  def test_team_collection_exists
    assert_instance_of TeamCollection, @collection
  end

  def test_team_collection_has_teams
    assert_instance_of Array, @collection.teams
    assert_equal 5, @collection.teams.length
  end

  def test_team_collection_can_create_team_from_csv
    assert_instance_of Team, @team
    assert_equal 'ATL', @team.abbreviation
    assert_equal "1", @team.team_id
  end
end
