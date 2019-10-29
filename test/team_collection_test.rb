require_relative 'test_helper'
require './lib/team_collection'
require './lib/stat_tracker'

class TeamCollectionTest < Minitest::Test

  def setup
    @team_collection= TeamCollection.new("./test/dummy_team_data.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  

end
