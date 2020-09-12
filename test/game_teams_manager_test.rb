require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_path = './fixture/games_dummy.csv'
    @team_path = './fixture/teams_dummy.csv'
    @game_teams_path = './fixture/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @stat_tracker.game_teams_manager
  end

  def test_find_team_results_by_season
    game_path = './fixture/game_blank.csv'
    team_path = './fixture/team_blank.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    tracker = StatTracker.new(game_path, team_path, game_teams_path)
    game_1 = mock("Season Game 1")
    game_2 = mock("Season Game 2")
    game_3 = mock("Season Game 3")
    tracker.game_manager.games << game_1
    tracker.game_manager.games << game_2
    tracker.game_manager.games << game_3

    game_teams_1 = mock("Game Team Object 1")
    game_teams_2 = mock("Game Team Object 2")
    game_teams_3 = mock("Game Team Object 3")
    tracker.game_teams_manager.game_teams << game_teams_1
    tracker.game_teams_manager.game_teams << game_teams_2
    tracker.game_teams_manager.game_teams << game_teams_3

    game_1.stubs(:season).returns('20122013')
    game_2.stubs(:season).returns('20122013')
    game_3.stubs(:season).returns('20132014')
    game_1.stubs(:game_id).returns('123')
    game_2.stubs(:game_id).returns('456')
    game_3.stubs(:game_id).returns('789')
    game_teams_1.stubs(:game_id).returns('123')
    game_teams_2.stubs(:game_id).returns('987')
    game_teams_3.stubs(:game_id).returns('555')

    assert_equal [game_teams_1], tracker.game_teams_manager.game_team_results_by_season('20122013')
  end
end
