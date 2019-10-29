require_relative 'test_helper'
require_relative '../lib/game_collection'
require_relative '../lib/team_collection'
require_relative '../lib/stat_tracker'

class TeamCollectionTest < Minitest::Test

  def test_it_exists
    team_path = './test/dummy_team_data.csv'
    team_collection = TeamCollection.new(team_path)
    assert_instance_of TeamCollection, team_collection
  end

  def test_it_can_return_name_of_highest_scoring_visitor
    assert_equal "Orlando City SC", @game_collection.highest_scoring_visitor
  end
end
