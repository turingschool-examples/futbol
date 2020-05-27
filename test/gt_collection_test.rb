require 'minitest/autorun'
require 'minitest/pride'
require './test/setup'
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

  def test_it_can_find_all_by_id
    result = @gt_collection.find_all_by(6)
    assert_instance_of Array, result
    assert_equal 6, result.first.team_id
    assert_equal 3, result.count
    assert_equal "WIN", result.first.result
  end
end
