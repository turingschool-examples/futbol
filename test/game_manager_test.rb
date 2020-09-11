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
    assert_equal [], @stat_tracker.game_manager.games_of_season('20122013')
  end
end
