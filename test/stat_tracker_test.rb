require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./data/games.csv", # "./test/fixtures/games_sample.csv",
                  game_teams: "./data/game_teams.csv", # "./test/fixtures/game_teams_sample.csv",
                  teams: "./data/teams.csv" # "./test/fixtures/teams_sample.csv"
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
    skip
    assert_equal 100, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_select_games_that_a_team_played
    skip
  end

  def test_it_can_calc_win_percentage
    games = [
              Game.new({home_team_id: 1, home_goals: 5, away_team_id: 2, away_goals: 1}),
              Game.new({home_team_id: 2, home_goals: 20, away_team_id: 1, away_goals: 5})
            ]
    team = Team.new({team_id: 1, teamname: "taco terrors"})
    @stat_tracker.win_percentage(games, team)
  end

  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end
  def test_it_knows_worst_offense
    assert_equal  "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_knows_best_defense
    assert_equal "FC Cincinnati", @stat_tracker.best_defense
  end

  def test_it_knows_worst_defense
    assert_equal "Columbus Crew SC", @stat_tracker.worst_defense
  end

  def test_it_knows_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_knows_winningest_team
    assert_equal "Reign FC", @stat_tracker.winningest_team
  end

  def test_it_knows_best_fans
    assert_equal "San Jose Earthquakes", @stat_tracker.best_fans
  end

  def test_it_knows_worst_fans
    assert_equal ["Houston Dynamo", "Utah Royals FC"], @stat_tracker.worst_fans
  end
end
