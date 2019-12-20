require './test/test_helper'
require './lib/game_teams_collection'
require './lib/game_teams'


class GameTeamsCollectionTest < Minitest::Test
  def setup
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @game_teams = @game_teams_collection.game_teams_array.first
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_teams_collection.game_teams_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of GameTeams, @game_teams
    assert_equal "away", @game_teams.hoa
    assert_equal "LOSS", @game_teams.result
  end

  def test_it_can_store_game_teams_by_id
    var = @game_teams_collection.game_teams_lists_by_id.first
    name = var[0]
    value = var[1]
    test_hash = {name => value}
    assert_equal 9, @game_teams_collection.game_teams_lists_by_id.length
  end

  def test_it_can_get_home_games_only
    assert_equal 3, @game_teams_collection.home_games_only["26"].length
  end

  def test_it_can_get_home_games_only_average
    assert_equal 2.33, @game_teams_collection.home_games_only_average["26"]
  end

  def test_it_can_get_away_games_only
    assert_equal 2, @game_teams_collection.away_games_only["26"].length
  end

  def test_it_can_get_team_with_highest_average_score_for_away_games
    skip
    assert_equal [24, 5], @game_teams_collection.highest_scoring_visitor
  end

  def test_it_can_get_team_with_lowest_average_score_for_away_games
    skip
    assert_equal 19, @game_teams_collection.lowest_scoring_visitor
  end

  def test_it_can_get_team_with_highest_average_score_for_home_games
    skip
    assert_equal [24, 5], @game_teams_collection.highest_scoring_home_team
  end

  def test_it_can_get_team_with_lowest_average_score_for_home_games
    skip
    assert_equal 3, @game_teams_collection.lowest_scoring_home_team
  end
end
