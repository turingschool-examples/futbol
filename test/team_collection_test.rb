require './test/test_helper'

class TeamCollectionTest < Minitest::Test
  def setup
    @team_collection = TeamCollection.new('./test/data/team_sample.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end
end
