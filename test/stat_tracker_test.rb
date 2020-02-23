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
    @locations = {
                  games: "./test/fixtures/season_games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                  }
    @stat_tracker = StatTracker.from_csv(@locations)

    assert_instance_of StatTracker, StatTracker.new
  end

  def test_from_csv_returns_new_instance
    @locations = {
                  games: "./test/fixtures/season_games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                  }
    @stat_tracker = StatTracker.from_csv(@locations)

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_items
    @locations = {
                  games: "./test/fixtures/season_games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                  }
    @stat_tracker = StatTracker.from_csv(@locations)
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)

    assert_instance_of Team, Team.all[1]
  end

  def test_from_csv_loads_all_three_files
    @locations = {
                  games: "./test/fixtures/season_games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                  }
    @stat_tracker = StatTracker.from_csv(@locations)

    assert_equal 20, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_find_eligible_teams
    @locations = {
                games: "./data/games.csv",
                game_teams: "./test/fixtures/game_teams_sample.csv",
                teams: "./test/fixtures/teams_sample.csv"
                }
    @stat_tracker = StatTracker.from_csv(@locations)

    assert_equal true, @stat_tracker.find_eligible_teams(20132014).include?("Montreal Impact")
  end

end
