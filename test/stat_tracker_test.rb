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
                  teams: "./data/teams.csv",
                }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def teardown
    Game.games = {}
    Team.teams = {}
    GameTeam.game_teams = {}
  end

  def test_it_can_find_games
    assert_equal 720, @stat_tracker.find_games(20122013, "Regular Season").count
    assert_equal 1230, @stat_tracker.find_games(20142015, "Regular Season").count
    assert_equal 86, @stat_tracker.find_games(20122013, "Postseason").count
    assert_equal 89, @stat_tracker.find_games(20142015, "Postseason").count
  end

  def test_it_finds_regular_season_teams
    assert_equal 30, @stat_tracker.find_regular_season_teams(20142015).count
    assert_equal true, @stat_tracker.find_regular_season_teams(20142015).include?(26)
    assert_equal false, @stat_tracker.find_regular_season_teams(20142015).include?(59)
  end

  def test_it_has_post_season_teams
    assert_equal 16, @stat_tracker.find_post_season_teams(20142015).count
  end



  def test_it_can_find_eligible_teams
    assert_equal true, @stat_tracker.find_eligible_teams(20142015).include?(14)
    assert_equal true, @stat_tracker.find_eligible_teams(20142015).include?(5)
    assert_equal true, @stat_tracker.find_eligible_teams(20132014).include?(23)
  end

  def test_it_can_calculate_regular_season_win_percentage
    assert_equal 0.479, @stat_tracker.win_percentage(20122013, 6, "Regular Season")
    assert_equal 0.39, @stat_tracker.win_percentage(20142015, 14, "Regular Season")
  end

  def test_it_can_calculate_post_season_win_percentage
    assert_equal 0.682, @stat_tracker.win_percentage(20122013, 6, "Postseason")
    assert_equal 0.167, @stat_tracker.win_percentage(20122013, 3, "Postseason")
    assert_equal 0, @stat_tracker.win_percentage(20132014, 23, "Postseason")
  end

  def test_it_can_calculate_biggest_bust
    assert_equal "Sporting Kansas City", @stat_tracker.biggest_bust(20142015)
    assert_equal "Montreal Impact", @stat_tracker.biggest_bust(20132014)
  end

  def test_it_can_calculate_biggest_surprise
    assert_equal "Minnesota United FC", @stat_tracker.biggest_surprise(20142015)
    assert_equal "FC Cincinnati", @stat_tracker.biggest_surprise(20132014)
  end
end
