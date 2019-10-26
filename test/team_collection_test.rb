require './test/test_helper'
require 'csv'
require './lib/team'
require './lib/stat_tracker'
require './lib/team_collection'

class TeamsCollectionTest < MiniTest::Test

  def setup
    @team_instance = TeamCollection.new('./dummy_data/dummy_teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_instance
  end

  def test_the_count_of_teams
    assert_equal 15, @team_instance.count_of_teams
  end

end
