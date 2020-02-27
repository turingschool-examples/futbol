require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'

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

  def test_it_knows_team_info
    expected = {
      "team_id" => "3",
      "franchise_id" => "10",
      "team_name" => "Houston Dynamo",
      "abbreviation" => "HOU",
      "link" => "/api/v1/teams/3"
      }
    assert_equal expected, @team_collection.team_info("3")
  end

  def test_it_can_return_a_team
    assert_equal Team, @team_collection.retrieve_team(18).class
    assert_equal 18, @team_collection.retrieve_team(18).team_id
  end
end
