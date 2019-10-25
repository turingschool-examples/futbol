require_relative 'test_helper'
require './lib/game_team_collection'
require './lib/stat_tracker'

class GameTeamCollectionTest < Minitest::Test

  def setup
    @game_team_collection= GameTeamCollection.new("./test/test_game_team_data.csv")
  end

  def test_count_of_teams
    assert_equal 12, @game_team_collection.count_of_teams
  end

  def test_best_fans
    skip
    assert_equal cc, @game_team_collection.best_fans
  end
end
