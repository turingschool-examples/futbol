require './test/test_helper'
require './lib/game_team_collection'
require './lib/game_collection'
require './lib/team_collection'

class CollectionsTest < Minitest::Test

  def setup
    @game_collection = GameCollection.load_data('./data/dummy_games.csv')
    @team_collection = TeamCollection.load_data('./data/dummy_teams.csv')
    @game_team_collection = GameTeamCollection.load_data('./data/dummy_game_teams.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
    assert_instance_of TeamCollection, @team_collection
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_returns_hash_of_game_id_keys_with_game_object_values
    assert_equal 20, @game_collection.games.values.length
    assert_instance_of Game, @game_collection.games["2012030311"]
    assert_equal "2012030311", @game_collection.games["2012030311"].game_id
  end

  def test_it_returns_hash_team_id_keys_with_team_object_values
    assert_equal 20, @team_collection.teams.values.length
    assert_instance_of Team, @team_collection.teams["1"]
    assert_equal "1", @team_collection.teams["1"].team_id
  end

  def test_it_returns_hash_of_game_id_keys_with_array_of_two_objects_as_values
    assert_equal 2, @game_team_collection.game_teams["2012030221"].length
    assert_instance_of Array, @game_team_collection.game_teams["2012030221"]
    assert_instance_of GameTeam, @game_team_collection.game_teams["2012030221"].first
    assert_equal "2012030221", @game_team_collection.game_teams["2012030221"].first.game_id
  end

end
