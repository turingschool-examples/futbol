require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './fixture/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
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

    game_1.stubs(:season).returns('20122013')
    game_2.stubs(:season).returns('20122013')
    game_3.stubs(:season).returns('20132014')
    game_1.stubs(:game_id).returns('123')
    game_2.stubs(:game_id).returns('456')
    game_3.stubs(:game_id).returns('789')

    assert_equal ["123", "456"], tracker.find_game_ids_for_season('20122013')
  end

  def test_it_can_find_team_info
    expected = {
      'team_id'=> "4",
      'franchise_id'=>  "16",
      'team_name'=>  "Chicago Fire",
      'abbreviation'=>  "CHI",
      'link'=>  "/api/v1/teams/4"
    }
    assert_equal expected, @stat_tracker.team_info("4")
  end

  def test_it_can_find_best_season
    assert_equal "20122013", @stat_tracker.best_season("6")
  end

  def test_it_can_find_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("6")
  end

  def test_it_can_find_average_win_percentage
    assert_equal 1.0, @stat_tracker.average_win_percentage("6")
    assert_equal 0.43, @stat_tracker.average_win_percentage('16')
  end

end
