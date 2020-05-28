require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test

  def setup
    @team_path = './data/teams.csv'
    @team_collection = TeamCollection.new(@team_path)
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_can_return_all_games
    assert_instance_of Team, @team_collection.all[0]
  end

  # def test_all 
  # end
end
