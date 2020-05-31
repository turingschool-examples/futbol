require './test/helper_test'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require './lib/team'
require './lib/team_collection'
require './lib/game_team'
require './lib/game_team_collection'
require './lib/season_stats'
require 'pry'

class SeasonStatsTest < Minitest::Test
  def setup
    games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    teams_collection = TeamCollection.new("./data/teams.csv")
    game_teams_collection = GameTeamCollection.new("./test/fixtures/game_teams_truncated.csv")

    locations = {
      games_collection: games_collection,
      teams_collection: teams_collection,
      game_teams_collection: game_teams_collection
      }

    @season_stats = SeasonStats.new(locations)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @season_stats.games_collection
    assert_instance_of TeamCollection, @season_stats.teams_collection
    assert_instance_of GameTeamCollection, @season_stats.game_teams_collection
  end

  def test_it_can_get_games_by_season
    assert_equal 40, @season_stats.games_by_season("20122013").count
  end

  def test_game_ids_by_season
    assert_instance_of Array, @season_stats.game_ids_by_season("20122013")
    assert_equal 40, @season_stats.game_ids_by_season("20122013").count
    assert_equal 40, @season_stats.game_ids_by_season("20132014").count
    assert_equal 40, @season_stats.game_ids_by_season("20142015").count
    assert_equal 40, @season_stats.game_ids_by_season("20152016").count
    assert_equal 40, @season_stats.game_ids_by_season("20162017").count
    assert_equal 40, @season_stats.game_ids_by_season("20172018").count
  end

  def test_game_teams_by_season
    assert_instance_of Array, @season_stats.game_teams_by_season("20122013")
    assert_equal 40, @season_stats.game_teams_by_season("20122013").count
    assert_equal 40, @season_stats.game_teams_by_season("20132014").count
    assert_equal 40, @season_stats.game_teams_by_season("20142015").count
    assert_equal 40, @season_stats.game_teams_by_season("20152016").count
    assert_equal 40, @season_stats.game_teams_by_season("20162017").count
    assert_equal 40, @season_stats.game_teams_by_season("20172018").count
  end
end
