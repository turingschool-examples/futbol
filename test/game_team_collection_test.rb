require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_team'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_team_collection = GameTeamCollection.new
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_can_return_all_games
    assert_instance_of GameTeam, @game_team_collection.all[0]
  end
end
