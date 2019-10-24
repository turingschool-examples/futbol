require_relative 'test_helper'
require './lib/game_team_collection'
require './lib/stat_tracker'

class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_teams_collection= GameTeamCollection.new("./test/test_game_team_data.csv")
  end

  def test_count_of_teams
    assert_equal 7, @game_teams_collection.count_of_game_teams
  end

end
