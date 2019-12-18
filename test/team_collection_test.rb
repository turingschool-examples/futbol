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
    assert_equal 1, @team.team_id
    
  end
  # def test_team_collection_has_teams_instance_variable
  #   collection = TeamCollection.new

  #   assert_nil collection.teams
  # end

  # def test_file_path_locations
  #   collection = TeamCollection.new

  #   assert_equal './data/teams.csv', collection.teams_file_path
  # end

  # def test_team_collection_can_have_csv_data_added
  #   collection = TeamCollection.new

  #   refute_nil collection.from_csv
  # end
end
