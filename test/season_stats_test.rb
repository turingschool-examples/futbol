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

  def test_it_has_a_winningest_coach
    season_id = "20122013"
    assert_equal "Claude Julien", @season_stats.winningest_coach(season_id)
  end

  # def test_it_has_a_worst_coach
  # end
  #
  # def test_it_has_a_most_accurate_team
  # end
  #
  # def test_it_has_a_least_accurate_team
  # end
  #
  # def test_it_has_most_tackles
  # end
  #
  # def test_it_has_fewest_tackles
  # end

  def test_it_can_get_total_games_for_a_coach
    assert_equal 4, @season_stats.total_games("John Tortorella")
  end

  def test_it_can_get_total_wins_for_a_coach
    assert_equal 2, @season_stats.total_games("Paul MacLean")
  end
end
