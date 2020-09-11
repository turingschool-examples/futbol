require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'


class GameManagerTest < Minitest::Test
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
    assert_instance_of GameManager, @stat_tracker.game_manager
  end

  def test_it_can_read_csv_games_data
    assert_equal '2012030221', @stat_tracker.game_manager.games[0].game_id
    assert_equal '20122013', @stat_tracker.game_manager.games[0].season
    assert_equal 'Postseason', @stat_tracker.game_manager.games[0].type
    assert_equal '5/16/13', @stat_tracker.game_manager.games[0].date_time
    assert_equal '3', @stat_tracker.game_manager.games[0].away_team_id
    assert_equal '6', @stat_tracker.game_manager.games[0].home_team_id
    assert_equal '2', @stat_tracker.game_manager.games[0].away_goals
    assert_equal '3', @stat_tracker.game_manager.games[0].home_goals
    assert_equal 'Toyota Stadium', @stat_tracker.game_manager.games[0].venue
    assert_equal '/api/v1/venues/null', @stat_tracker.game_manager.games[0].venue_link
  end

  def test_it_finds_game_of_season
    path = './fixture/game_blank.csv'
    game_manager = GameManager.new(path, nil)
    game_1 = mock("Season Game 1")
    game_2 = mock("Season Game 2")
    game_3 = mock("Season Game 3")
    game_manager.games << game_1
    game_manager.games << game_2
    game_manager.games << game_3

    game_manager.games[0].stubs(:season).returns('20122013')
    game_manager.games[1].stubs(:season).returns('20122013')
    game_manager.games[2].stubs(:season).returns('20132014')
    assert_equal [game_1, game_2], game_manager.games_of_season('20122013')
  end

  def test_find_game_ids_per_season
    path = './fixture/game_blank.csv'
    game_manager = GameManager.new(path, nil)
    game_1 = mock("Season Game 1")
    game_2 = mock("Season Game 2")
    game_3 = mock("Season Game 3")
    game_manager.games << game_1
    game_manager.games << game_2
    game_manager.games << game_3

    game_manager.games[0].stubs(:season).returns('20122013')
    game_manager.games[1].stubs(:season).returns('20122013')
    game_manager.games[2].stubs(:season).returns('20132014')
    game_manager.games[0].stubs(:game_id).returns('123')
    game_manager.games[1].stubs(:game_id).returns('456')
    game_manager.games[2].stubs(:game_id).returns('789')

    assert_equal ["123", "456"], game_manager.find_game_ids_for_season('20122013')
  end
end
