require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def test_it_exists
    assert_instance_of StatTracker, StatTracker.new
  end

  def test_from_csv_returns_new_instance
    locations = {
                  games: "./test/fixtures/games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                }

    assert_instance_of StatTracker, StatTracker.from_csv(locations)
  end

  def test_it_can_create_items
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)

    assert_instance_of Team, Team.all[1]
  end

  def test_from_csv_loads_all_three_files
    locations = {
                  games: "./test/fixtures/games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                }
    StatTracker.from_csv(locations)

    assert_equal 100, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_knows_how_many_teams_there_are
    stat_tracker = StatTracker.new
    assert_equal 32, stat_tracker.count_of_teams
  end

  def test_it_can_calc_best_offense
    stat_tracker = StatTracker.new
    assert_equal "FC Cincinnati", stat_tracker.best_offense
  end


end
