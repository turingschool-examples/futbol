require './test/test_helper'

class TeamCollectionTest < Minitest::Test
  def setup
    @team_collection = TeamCollection.new('./test/data/team_sample.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_total_teams
    assert_equal 5, @team_collection.total_teams
  end

  def test_find_by_id
    assert_equal "1", @team_collection.find_by_id("1").team_id
  end

  def test_find_name_by_id
    assert_equal "Atlanta United", @team_collection.find_name_by_id("1")
  end

  def test

  end
end
