require './test/test_helper'
require './lib/game_teams_collection'

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

  def test_it_can_make_a_game_teams_hash
    game_teams_hash = @game_teams_collection.game_teams_hash

    assert_equal 4, game_teams_hash["20"].length
    assert_equal 5, game_teams_hash["3"].length
  end

  def test_it_can_find_win_percentage_of_a_team
    hash = @game_teams_collection.game_teams_hash
    assert_equal 40, @game_teams_collection.team_win_percentage(hash, "26")
  end

  def test_it_can_find_winningest_team_id
    assert_equal "24", @game_teams_collection.winningest_team_id
  end

  def test_it_can_find_home_percentage
    hash = @game_teams_collection.game_teams_hash
    assert_equal 33.33, @game_teams_collection.home_percentage(hash, "26")
  end

  def test_it_can_find_away_percentage
    hash = @game_teams_collection.game_teams_hash
    assert_equal 50, @game_teams_collection.away_percentage(hash, "26")
  end

  def test_it_can_calculate_home_or_away_differences
    hash = @game_teams_collection.game_teams_hash
    diffs = @game_teams_collection.hoa_differences(hash)
    assert diffs.find { |key, value| value < 0 }
    assert diffs.find { |key, value| value == 0 }
  end

  def test_it_can_find_id_of_team_with_best_fans
    assert_equal "20", @game_teams_collection.best_fans_id
  end

  def test_it_can_find_teams_with_worst_fans
    skip
    assert_equal [], @game_teams_collection.worst_fans_ids
  end
end
