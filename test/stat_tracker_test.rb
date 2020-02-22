require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./data/games.csv",
                  game_teams: "./data/game_teams.csv",
                  teams: "./data/teams.csv"
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
    assert_equal 7441, Game.all.count
    assert_equal 7441, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_get_team_info_by_team_id
    expected = {
          team_id: 1,
          franchiseid: 23,
          teamname: "Atlanta United",
          abbreviation: "ATL",
          link: "/api/v1/teams/1"
        }

    assert_instance_of Hash, @stat_tracker.team_info(1)
    assert_equal expected, @stat_tracker.team_info(1)
    assert_equal 5, @stat_tracker.team_info(1).count
    assert_equal 5, @stat_tracker.team_info(5).count
  end

  def test_it_can_get_all_game_teams_by_team_id_in_array
    assert_instance_of Array, @stat_tracker.all_game_teams_by_team_id(3)
    assert_equal 531, @stat_tracker.all_game_teams_by_team_id(3).length

    assert_instance_of Array, @stat_tracker.all_game_teams_by_team_id(5)
    assert_equal 552, @stat_tracker.all_game_teams_by_team_id(5).length
  end

  def test_it_can_get_all_games_by_team_id_in_array
    assert_instance_of Array, @stat_tracker.all_games_by_team_id(3)
    assert_equal 531, @stat_tracker.all_games_by_team_id(3).length

    assert_instance_of Array, @stat_tracker.all_games_by_team_id(5)
    assert_equal 552, @stat_tracker.all_games_by_team_id(5).length
  end

  def test_it_can_get_total_results_by_team_id
    assert_instance_of Array, @stat_tracker.total_results_by_team_id(3)
    assert_equal 531, @stat_tracker.total_results_by_team_id(3).length

    assert_instance_of Array, @stat_tracker.total_results_by_team_id(5)
    assert_equal 552, @stat_tracker.total_results_by_team_id(5).length
  end

  def test_it_can_get_average_win_percentage_by_team_id
    assert_equal 0.36, @stat_tracker.average_win_percentage(1)
    assert_equal 0.43, @stat_tracker.average_win_percentage(3)
    assert_equal 0.48, @stat_tracker.average_win_percentage(5)
    assert_equal 0.49, @stat_tracker.average_win_percentage(6)
  end

  def test_it_can_get_all_goals_scored_by_team_id
    assert_instance_of Array, @stat_tracker.all_goals_scored_by_team_id(3)
    assert_equal 531, @stat_tracker.all_goals_scored_by_team_id(3).length
    assert_equal 2, @stat_tracker.all_goals_scored_by_team_id(3).first
    assert_equal 0, @stat_tracker.all_goals_scored_by_team_id(5).first
    assert_equal 3, @stat_tracker.all_goals_scored_by_team_id(6).first
  end

  def test_it_can_get_most_goals_scored_by_team_id
    assert_equal 6, @stat_tracker.most_goals_scored(5)
    assert_equal 6, @stat_tracker.most_goals_scored(3)
    assert_equal 6, @stat_tracker.most_goals_scored(6)
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(5)
    assert_equal 0, @stat_tracker.fewest_goals_scored(3)
    assert_equal 0, @stat_tracker.fewest_goals_scored(6)
  end

  def test_it_can_get_score_differences_by_team_id
    assert_equal 531, @stat_tracker.score_differences_by_team_id(3).length
    assert_equal -1, @stat_tracker.score_differences_by_team_id(3).first

    assert_equal 552, @stat_tracker.score_differences_by_team_id(5).length
    assert_equal -3, @stat_tracker.score_differences_by_team_id(5).first
  end

  def test_it_can_get_biggest_team_blowout
    assert_equal 5, @stat_tracker.biggest_team_blowout(5)
    assert_equal 4, @stat_tracker.biggest_team_blowout(3)
    assert_equal 4, @stat_tracker.biggest_team_blowout(6)
  end

  def test_it_can_get_worst_loss
    assert_equal 7, @stat_tracker.worst_loss(5)
    assert_equal 5, @stat_tracker.worst_loss(3)
    assert_equal 5, @stat_tracker.worst_loss(6)
  end

  def test_it_can_get_team_name
    assert_equal "Houston Dynamo", @stat_tracker.get_team_name(3)
    assert_equal "FC Dallas", @stat_tracker.get_team_name(6)
    assert_equal "Reign FC", @stat_tracker.get_team_name(54)
  end

  def test_it_can_get_rival
    assert_equal "Reign FC", @stat_tracker.rival(3)
    assert_equal "Reign FC", @stat_tracker.rival(5)
    assert_equal "Reign FC", @stat_tracker.rival(6)
  end
end
