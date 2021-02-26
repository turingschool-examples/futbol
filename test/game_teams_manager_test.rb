require './test/test_helper'
require './lib/game_teams_manager'


class GameTeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GamesTeamsManager.new(path)

    assert_instance_of GamesTeamsManager, game_team_manager
  end

  def test_it_has_attributes

    #CSV.stubs(:foreach).returns([])

    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GamesTeamsManager.new(path)

    assert_equal 15, game_team_manager.games.length
    assert_instance_of GameTeams, game_team_manager.games[0]
    assert_instance_of GameTeams, game_team_manager.games[-1]
  end

  # def test_most_tackles
  #   game_team_path = './fixture/game_teams_dummy15.csv'
  #   tracker = GameTeam.new(game_team_path)
  #
  #   assert_equal "6", tracker.most_tackles(20122013)
  # end
  #
  #
  # def test_fewest_tackles
  #   game_team_path = './fixture/game_teams_dummy15.csv'
  #   tracker = GameTeam.new(game_team_path)
  #
  #   assert_equal "5", tracker.fewest_tackles(20122013)
  # end
  #
  #
  #

    def test_get_team_tackle_hash

      path = "./fixture/game_teams_dummy15.csv"
      game_team_manager = GamesTeamsManager.new(path)

      game_ids = ["2012030221", "2012030222"]
      test = game_team_manager.get_team_tackle_hash(game_ids)

      assert_instance_of Hash, test
      assert_etual 77, test["3"]
      assert_etual 87, test["6"]
    end


end
