require_relative 'test_helper'

class GamesTeamsCollectionTest < Minitest::Test

  def setup
    @game_team_1 = GameTeam.new
    @game_team_2 = GameTeam.new
    @games_teams_array = [@game_team_1, @game_team_2]
    @games_teams_collection = GamesTeamsCollection.new(@games_teams_array)
  end

  def test_it_exists
    assert_instance_of GamesTeamsCollection, @games_teams_collection
  end

  def test_it_initializes_attributes
    assert_equal @games_teams_array, @games_teams_collection.games_teams
  end
end
