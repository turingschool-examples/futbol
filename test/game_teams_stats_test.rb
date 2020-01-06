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

  def test_it_can_calculate_home_or_away_differences
    hash = @game_teams_collection.game_teams_hash
    diffs = @game_teams_stats.hoa_differences(hash)
    assert diffs.find { |key, value| value < 0 }
    assert diffs.find { |key, value| value == 0 }
  end

  def test_it_can_get_the_total_goals_by_game_team_id
    assert_equal 7, @game_teams_stats.total_goals_by_team_id(20)
  end

  def test_it_can_calculate_average_goals_by_team_id
    assert_equal 1.75, @game_teams_stats.average_goals_per_team_id(20)
  end

  def test_it_can_get_home_games_only_average
    assert_equal 2.33, @game_teams_stats.home_games_only_average[26]
  end

  def test_it_can_get_away_games_only_average
      assert_equal 2.0, @game_teams_stats.away_games_only_average[26]
  end



end
