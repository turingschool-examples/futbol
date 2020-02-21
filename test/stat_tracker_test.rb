require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./test/fixtures/games_sample.csv",
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
    assert_equal 100, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_calculate_win_percentage
    assert_equal 0.167, @stat_tracker.win_percentage(20122013, 3)
  end
#  def test_biggest_bust
#


#    For each team in that season , we need
#    win_percentage("Regular Season") - win_percentage("Postseason")
#    return Team Name with largest number difference

#    Store list of win percentages by season with team name and result of win percentage differential

#    Team Name

#    Game.all

#  end

end
