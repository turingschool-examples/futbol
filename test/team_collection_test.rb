require_relative 'test_helper'

class TeamCollectionTest < Minitest::Test
  def setup
    @team_file_path =
    @team_data = CSV.read('./data/teams.csv',headers: true, header_converters: :symbol)
    @team_collection = TeamCollection.new(@team_data)
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  
end
