require './test/test_helper'
require './lib/season_stats'
require './lib/team_collection'
require './lib/game_collection'
require './lib/game_team_collection'


class SeasonStatsTest < Minitest::Test

  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @game_collection = GameCollection.new('./data/games_fixture.csv')
    @game_team_collection = GameTeamCollection.new('./data/game_teams_fixture.csv')
    @season_stats = SeasonStats.new(@game_collection, @game_team_collection, @team_collection)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_collections_as_attributes
    assert_equal @team_collection, @season_stats.team_collection
    assert_equal @game_collection, @season_stats.game_collection
    assert_equal @game_team_collection, @season_stats.game_team_collection
  end

  def test_it_finds_best_offense
    assert_equal "FC Dallas", @season_stats.best_offense
  end

  def test_it_finds_worst_offense
      assert_equal "Seattle Sounders FC", @season_stats.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @season_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Real Salt Lake", @season_stats.highest_scoring_home_team
  end

  def test_it_has_a_winningest_coach
    season_id = "20122013"
    assert_equal "Claude Julien", @season_stats.winningest_coach(season_id)
  end

  def test_it_finds_worst_coach
    season_id = "20122013"
    assert_equal "John Tortorella", @season_stats.worst_coach(season_id)
  end





  def test_it_has_most_accurate_team
    assert_equal "New York City FC", @season_stats.most_accurate_team("20122013")
  end

  def test_it_has_least_accurate_team
    assert_equal "New York Red Bulls", @season_stats.least_accurate_team("20122013")
  end

  def test_it_finds_team_with_most_tackles
    season_id = "20122013"
    assert_equal "New York City FC", @season_stats.most_tackles(season_id)
  end

  def test_it_finds_team_with_least_tackles
    season_id = "20122013"
    assert_equal "FC Dallas", @season_stats.least_tackles(season_id)
  end

  def test_it_finds_favorite_opponent
    assert_equal "FC Dallas", @season_stats.favorite_opponent(8)
  end

  def test_it_finds_rival
    assert_equal "FC Dallas", @season_stats.rival(8)
  end
end
