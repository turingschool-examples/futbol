require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_team'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_teams_path = './data/game_teams.csv'
    @game_team_collection = GameTeamCollection.new(@game_teams_path)
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_can_return_all_games
    assert_instance_of GameTeam, @game_team_collection.all[0]
  end

  def test_all
    assert_equal Array, @game_team_collection.all.class
  end
end
