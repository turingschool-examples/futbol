require './test/test_helper'
require './lib/game_team_collection'
require './lib/game_collection'
require './lib/team_collection'

class CollectionsTest < Minitest::Test

  def setup
    @game_team_collection = GameTeamCollection.load_data('./data/dummy_game_teams.csv')
  end

  def test_it_exists
    # assert_instance_of GameCollection,
    # assert_instance_of TeamCollection,
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_returns_hash_of_game_id_keys_with_array_of_2_objects
    assert_equal 2, @game_team_collection.game_teams["2012030221"].length
    assert_instance_of Array, @game_team_collection.game_teams["2012030221"]
    assert_instance_of GameTeam, @game_team_collection.game_teams["2012030221"].first
    assert_equal "2012030221", @game_team_collection.game_teams["2012030221"].first.game_id
  end

  def test_most_visitor_goals
    assert_equal "6", @game_team_collection.most_visitor_goals
  end

  def test_most_home_goals
    assert_equal "6", @game_team_collection.most_home_goals
  end

  def test_away_games
    @game_team_collection.away_games
  end
end
