require './test/test_helper'
require './lib/game_teams'
# CHANGE THIS TO SINGULAR ^
require './lib/game_team_collection'


class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_team_collection = GameTeamCollection.new('./data/game_teams.csv')
    @game_team = @game_team_collection.game_teams_array.first
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_team_collection.game_teams_array
  end

  def test_it_can_create_game_teams_from_csv
    assert_instance_of GameTeams, @game_team
    # change to SINGULAR ^
    assert_equal "2012030221", @game_team.game_id
    assert_equal "John Tortorella", @game_team.head_coach
  end

  def test_it_finds_games_played_that_season
    expected = {
                "2012"=>53.0,
                "2014"=>94.0,
                "2013"=>99.0,
                "2016"=>88.0,
                "2017"=>82.0,
                "2015"=>82.0}
    assert_equal expected, @game_team_collection.find_number_of_games_played_in_a_season(8)
  end

  def test_it_finds_best_season
    assert_equal "20162017", @game_team_collection.best_season(8)
  end

  def test_it_finds_worst_season
    assert_equal "20142015", @game_team_collection.worst_season(8)
  end

  def test_it_finds_average_win_percentage
    assert_equal 41.77, @game_team_collection.average_win_percentage(8)
  end

  def test_it_finds_most_goals_scored
    assert_equal 8, @game_team_collection.most_goals_scored(8)
  end

  def test_it_finds_least_goals_scored
    assert_equal 0, @game_team_collection.fewest_goals_scored(8)
  end
end
