require './test/test_helper'
require './lib/game_teams_collection'
require './lib/game_teams_stats'


class GameTeamsStatsTest < Minitest::Test
  def setup
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @game_teams_stats = GameTeamsStats.new(@game_teams_collection)
  end

  def test_it_exists
    assert_instance_of GameTeamsStats, @game_teams_stats
  end

  def test_it_has_attributes
    assert_instance_of GameTeamsCollection, @game_teams_stats.game_teams_collection
  end
end
