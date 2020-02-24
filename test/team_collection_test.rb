require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './team_collection'

class TeamCollectionTest < Minitest::Test

  def setup
    @team_file_path =
    @team_data = CSV.read('./data/teams.csv',
                          headers: true,
                          header_converters: :symbol)
    @team_collection = TeamCollection.new(@team_data)
  end

  def test_it_exists

    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_creates_team_objects

    assert_instance_of Team, @team_collection.teams.first
    assert_equal 32, @team_collection.teams.length
  end
end
