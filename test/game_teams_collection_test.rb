require 'csv'
require './lib/game_teams'
require './lib/stat_tracker'
require './lib/game_teams_collection'
require_relative 'test_helper'

class GameTeamsCollectionTest < MiniTest::Test
  def test_it_exists
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_instance_of GameTeamsCollection, new_game_tracker_instance
  end

  def test_winningest_team
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal "6", new_game_tracker_instance.winningest_team_id
  end
end
