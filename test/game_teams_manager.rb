require './test/test_helper'
require './lib/game_teams_manager'


class GameTeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/games_dummy15.csv"
    game_team_manager = GamesTeamsManager.new(path)

    assert_instance_of GamesTeamsManager, game_team_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    path = "./fixture/games_dummy15.csv"
    game_team_manager = GamesTeamsManager.new(path)

    assert_equal 15, game_team_manager.games.length
    assert_instance_of GameTeams, game_team_manager.games[0]
    assert_instance_of GameTeams, game_team_manager.games[-1]
  end
end
