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

  def test_it_finds_total_games_played_by_team
    @season_stats.expects(:total_number_games_played).returns({"6" => 10})
    assert_equal ({"6" => 10}), @season_stats.total_number_games_played
  end

  def test_it_finds_best_offense
    assert_equal "Atlanta United", @season_stats.best_offense
  end

  def test_it_finds_worst_offense
      assert_equal "Seattle Sounders FC", @season_stats.worst_offense
  end

  def test_it_has_a_winningest_coach
    assert_equal "Claude Julien", @season_stats.winningest_coach("20122013")
  end

  def test_it_finds_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end

  def test_it_has_most_accurate_team
    assert_equal "New York City FC", @season_stats.most_accurate_team("20122013")
  end

  def test_it_has_least_accurate_team
    assert_equal "New York Red Bulls", @season_stats.least_accurate_team("20122013")
  end

  def test_it_finds_team_with_most_tackles
    assert_equal "New York City FC", @season_stats.most_tackles("20122013")
  end

  def test_it_finds_team_with_least_tackles
    assert_equal "FC Dallas", @season_stats.fewest_tackles("20122013")
  end

  def test_it_finds_number_of_games_vs_opponent
    @season_stats.expects(:number_of_games_vs_oppenent).returns({"5" => 200})
    assert_equal ({"5" => 200}), @season_stats.number_of_games_vs_oppenent(6)

  end
  def test_it_finds_favorite_opponent
    assert_equal "FC Dallas", @season_stats.favorite_opponent(8)
  end

  def test_it_finds_rival
    assert_equal "FC Dallas", @season_stats.rival(8)
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @season_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Real Salt Lake", @season_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @season_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @season_stats.lowest_scoring_visitor
  end
end
