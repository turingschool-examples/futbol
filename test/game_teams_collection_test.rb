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
    var = @game_teams_collection.game_teams_hash.first
    name = var[0]
    value = var[1]
    test_hash = {name => value}
    assert_equal 9, @game_teams_collection.game_teams_hash.length
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

  def test_it_can_get_away_games_only_average
    assert_equal 2.0, @game_teams_collection.away_games_only_average["26"]
  end

  def test_it_can_get_team_with_highest_average_score_for_away_games
    assert_equal [24, 5], @game_teams_collection.highest_scoring_visitor
  end

  def test_it_can_get_team_with_lowest_average_score_for_away_games
    assert_equal [14, 19], @game_teams_collection.lowest_scoring_visitor
  end

  def test_it_can_get_team_with_highest_average_score_for_home_games
    assert_equal [24, 5], @game_teams_collection.highest_scoring_home_team
  end

  def test_it_can_get_team_with_lowest_average_score_for_home_games
    assert_equal [3], @game_teams_collection.lowest_scoring_home_team
  end

  def test_it_can_find_the_number_of_games_by_the_game_team_id
    assert_instance_of GameTeams, @game_teams
    assert_equal 4, @game_teams_collection.games_by_team_id(20).count
    assert_equal 4, @game_teams_collection.games_by_team_id(24).count
  end

  def test_it_can_get_the_total_goals_by_game_team_id
    assert_equal 7, @game_teams_collection.total_goals_by_team_id(20)
  end

  def test_total_games_per_team
    assert_equal 6, @game_teams_collection.total_games_per_team(14)
  end

  def test_it_can_calculate_average_goals_by_team_id
    assert_equal 1.75, @game_teams_collection.average_goals_per_team_id(20)
  end

  def test_best_offense
    assert_equal 24, @game_teams_collection.best_offense
  end

  def test_worst_offense
    assert_equal 14, @game_teams_collection.worst_offense
  end

  def test_it_can_make_a_game_teams_hash
    game_teams_hash = @game_teams_collection.game_teams_hash

    assert_equal 4, game_teams_hash[20].length
    assert_equal 5, game_teams_hash[3].length
  end

  def test_it_can_find_win_percentage_of_a_team
    hash = @game_teams_collection.game_teams_hash
    assert_equal 40, @game_teams_collection.team_win_percentage(hash, 26)
  end

  def test_it_can_find_winningest_team_id
    assert_equal 24, @game_teams_collection.winningest_team_id
  end

  def test_it_can_calculate_home_or_away_differences
    hash = @game_teams_collection.game_teams_hash
    diffs = @game_teams_collection.hoa_differences(hash)
    assert diffs.find { |key, value| value < 0 }
    assert diffs.find { |key, value| value == 0 }
  end

  def test_it_can_find_id_of_team_with_best_fans
    assert_equal 20, @game_teams_collection.best_fans_id
  end

  def test_it_can_find_teams_with_worst_fans
    expected = [16, 14, 5, 28, 26, 19]
    assert_equal expected, @game_teams_collection.worst_fans_ids
  end
end
