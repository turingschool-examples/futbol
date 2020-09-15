require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
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

    game_1.stubs(:season).returns('20122013')
    game_2.stubs(:season).returns('20122013')
    game_3.stubs(:season).returns('20132014')
    game_1.stubs(:game_id).returns('123')
    game_2.stubs(:game_id).returns('456')
    game_3.stubs(:game_id).returns('789')

    assert_equal ["123", "456"], tracker.find_game_ids_for_season('20122013')
  end
end

#----------------GameStatistics

def test_it_can_find_highest_total_score
  game_path = './fixture/game_blank.csv'
  team_path = './fixture/team_blank.csv'
  game_teams_path = './fixture/game_teams_blank.csv'

  tracker = StatTracker.new(game_path, team_path, game_teams_path)
  game_1 = mock("Season Game 1")
  game_2 = mock("Season Game 2")
  game_3 = mock("Season Game 3")
  game_manager.games << game_1
  game_manager.games << game_2
  game_manager.games << game_3

  game_1.stubs(:away_goals).returns(6)
  game_1.stubs(:home_goals).returns(5)
  game_2.stubs(:away_goals).returns(3)
  game_2.stubs(:home_goals).returns(2)
  game_3.stubs(:away_goals).returns(0)
  game_3.stubs(:home_goals).returns(0)

  assert_equal 18, tracker.highest_total_score
end
