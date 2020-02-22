require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./test/fixtures/season_games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def teardown
    Game.games = {}
    Team.teams = {}
    GameTeam.game_teams = {}
  end

  def test_it_exists
    assert_instance_of StatTracker, StatTracker.new
  end

  def test_from_csv_returns_new_instance
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_items
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)

    assert_instance_of Team, Team.all[1]
  end

  def test_from_csv_loads_all_three_files
    assert_equal 20, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_calculate_post_season_win_percentage
    assert_equal 1.0, @stat_tracker.post_season_win_percentage(20122013, 6)
    assert_equal 0, @stat_tracker.post_season_win_percentage(20122013, 3)
  end

  def test_it_can_calculate_regular_season_win_percentage
    assert_equal 0.667, @stat_tracker.regular_season_win_percentage(20122013, 6)
  end

  def test_it_finds_season_games
    assert_equal 10, @stat_tracker.season_games(20122013).count
    assert_equal 10, @stat_tracker.season_games(20142015).count
  end

  def test_rs_win_percentage_by_team
    expected = {
                6=>0.667,
                3=>0.0,
                52=>1.0,
                1=>1.0,
                12=>0.0,
                14=>0.0,
                5=>1.0
              }
    assert_equal expected, @stat_tracker.rs_win_percentage_by_team(20122013)
  end

  def test_ps_win_percentage_by_team

    expected = {
                6=>1.0,
                3=>0.0,
              }
    assert_equal expected, @stat_tracker.ps_win_percentage_by_team(20122013)
  end

  def test_biggest_bust_team_number

    assert_equal 6, @stat_tracker.biggest_bust(20122013)
  end

end
