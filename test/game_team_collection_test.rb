require_relative 'test_helper'
require './lib/game_team_collection'
require './lib/stat_tracker'

class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_team_collection= GameTeamCollection.new("./test/dummy_game_team_data.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamCollection, @game_team_collection
  end

  def test_count_of_teams
    assert_equal 7, @game_team_collection.count_of_teams
  end

  def test_winningest_team
    assert_equal "LA Galaxy", @game_team_collection.winningest_team
  end


end
