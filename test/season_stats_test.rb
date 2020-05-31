require './test/helper_test'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require './lib/team'
require './lib/team_collection'
require './lib/game_team'
require './lib/game_team_collection'
require './lib/season_stats'

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

  # def test_it_can_get_games_by_coach
  #   assert_equal 4, @season_stats.games_by_coach("Claude Noel").count
  # end

  # def test_it_can_get_games_by_season
  #   assert_equal 40, @season_stats.games_by_season("20122013").count
  # end
  #
  # def test_it_can_get_game_teams_by_season
  #   assert_equal 40, @season_stats.game_teams_by_season("20122013").count
  # end
  #
  # def test_it_can_get_winningest_coach
  #   assert_equal "Claude Noel", @season_stats.winningest_coach("20122013")
  # end

  def test_it_can_get_team_with_most_tackles
    assert_equal "FC Dallas", @season_stats.most_tackles("20122013")
    assert_equal "San Jose Earthquakes", @season_stats.most_tackles("20132014")
    assert_equal "Real Salt Lake", @season_stats.most_tackles("20142015")
    assert_equal "Orlando Pride", @season_stats.most_tackles("20152016")
    assert_equal "New York City FC", @season_stats.most_tackles("20162017")
    assert_equal "Reign FC", @season_stats.most_tackles("20172018")
  end

  def test_it_can_get_team_with_fewest_tackles
    assert_equal "LA Galaxy", @season_stats.fewest_tackles("20122013")
    assert_equal "Los Angeles FC", @season_stats.fewest_tackles("20132014")
    assert_equal "New England Revolution", @season_stats.fewest_tackles("20142015")
    assert_equal "Vancouver Whitecaps FC", @season_stats.fewest_tackles("20152016")
    assert_equal "Atlanta United", @season_stats.fewest_tackles("20162017")
    assert_equal "DC United", @season_stats.fewest_tackles("20172018")
  end
end
