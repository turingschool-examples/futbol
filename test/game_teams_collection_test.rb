require_relative './test_helper'
require './lib/game_teams_collection'
require 'CSV'

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @gameteamcollection = GameTeamsCollection.new('./data/game_teams_dummy.csv')
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

  def test_goals_by_team

    expected = {3=>8, 6=>14}
    assert_equal expected, @gameteamcollection.goals_by_team
  end
end
