require_relative './test_helper'
require './lib/game_teams_collection'
require './lib/team'
require 'CSV'

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @gameteamcollection = GameTeamsCollection.new('./data/teams.csv', './data/game_teams_dummy.csv')
  end

  def test_it_exists

    assert_instance_of GameTeamsCollection, @gameteamcollection
  end

  def test_first_game

    assert_instance_of GameTeam, @gameteamcollection.game_teams[0]
  end

  def test_all_games

    assert_equal 10, @gameteamcollection.game_teams.length
  end

  def test_games_by_team

    expected = {"3"=>5, "6"=>5}
    assert_equal expected, @gameteamcollection.games_by_team
  end

  def test_average_goals_by_team

    expected = {"3"=>1.6, "6"=>2.8}
    assert_equal expected, @gameteamcollection.average_goals_by_team
  end

  def test_best_offense

    assert_equal "FC Dallas", @gameteamcollection.best_offense
  end

  def test_worst_offense
    assert_equal "Houston Dynamo", @gameteamcollection.worst_offense
  end
end
