require_relative 'test_helper'
require 'csv'
require './lib/game_team_collection'

class GameTeamCollectionTest < Minitest::Test
  def setup
    @collection = GameTeamCollection.new('./test/fixtures/game_teams_truncated.csv')
    @game_team = @collection.game_teams.first
  end

  def test_a_game_team_exists
    assert_instance_of GameTeamCollection, @collection
  end

  def test_game_team_has_game_teams
    assert_instance_of Array, @collection.game_teams
    assert_equal 375, @collection.game_teams.length
  end
end
