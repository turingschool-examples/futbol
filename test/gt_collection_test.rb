require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'
require './lib/gt_collection'

class GameTeamCollectionTest < Minitest::Test
  def setup
    @gt_collection = GameTeamCollection.new("./fixtures/game_teams_fixture.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @gt_collection
  end

  def test_it_can_collect_teams
    assert_instance_of GameTeam, @gt_collection.all.first
    assert_equal 6, @gt_collection.all.count
  end

end
