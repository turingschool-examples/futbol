require './test/test_helper'
require './lib/game_stats'
require './lib/team_collection'
require './lib/game_collection'
require './lib/game_team_collection'


class GameStatsTest < Minitest::Test

  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @game_collection = GameCollection.new('./data/games_fixture.csv')
    @game_team_collection = GameTeamCollection.new('./data/game_teams_fixture.csv')
    @season_stats = SeasonStats.new(@game_collection, @game_team_collection, @team_collection)
  end

  def test_it_has_highest_total_score
    assert_equal 7, @game_stats.highest_total_score
  end
  #
  # def test_it_has_lowest_total_score
  #   assert_equal 1, @game_collection.games_array.lowest_total_score
  # end
  #
  # def test_it_has_percentage_home_wins
  #   assert_equal 55.56, @game_collection.games_array.percentage_home_wins
  # end
  #
  # def test_it_has_percentage_visitor_wins
  #   assert_equal 38.89, @game_collection.games_array.percentage_visitor_wins
  # end
  #
  # def test_it_has_percentage_ties
  #   assert_equal 5.56, @game_collection.games_array.percentage_ties
  # end
  #
  # def test_it_finds_count_of_games_by_season
  #   @game_collection.games_array.expects(:count_of_games_by_season).returns({"20122013"=>3, "20142015"=>4})
  #   assert_equal ({"20122013"=>3, "20142015"=>4}), @game_collection.games_array.count_of_games_by_season
  # end
  #
  # def test_it_can_find_average_goals_per_game
  #   assert_equal 1.96, @game_collection.games_array.average_goals_per_game
  # end
  #
  # def test_has_average_goals_by_season
  #   @game_collection.games_array.expects(:average_goals_by_season).returns({"20122013"=>3, "20142015"=>4})
  #   assert_equal ({"20122013"=>3, "20142015"=>4}), @game_collection.games_array.average_goals_by_season
  # end
end
