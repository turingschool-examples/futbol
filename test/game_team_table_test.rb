require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_team_tables'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'
require './lib/helper_modules/csv_to_hashable'

class GameTeamTableTest < Minitest::Test
  include CsvToHash
  include ReturnTeamable
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    teams_test_path = './data/teams_test.csv'
    games_test_path = './data/games_test.csv'
    game_teams_test_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
    }
    stat_tracker = StatTracker.from_csv(locations)
    @game_teams = GameTeamTable.new(locations[:game_teams])
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @game_teams.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @game_teams.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @game_teams.worst_coach("20132014")
    assert_equal "Craig MacTavish" || "Ted Nolan", @game_teams.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal 24, @game_teams.most_accurate_team("20132014")
    assert_equal 14, @game_teams.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    assert_equal 9, @game_teams.least_accurate_team("20132014")
    assert_equal 53, @game_teams.least_accurate_team("20142015")
  end

  def test_most_tackles
    assert_equal 26, @game_teams.most_tackles("20132014")
    assert_equal 2, @game_teams.most_tackles("20142015")
  end

  def test_fewest_tackles
    assert_equal 1, @game_teams.fewest_tackles("20132014")
    assert_equal 30, @game_teams.fewest_tackles("20142015")
  end

  def test_best_offense

    assert_equal 54, @game_teams.best_offense
  end

  def test_highest_scoring_visitor

    assert_equal 6, @game_teams.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 27, @game_teams.lowest_scoring_visitor
  end

  def test_average_win_percentage
    assert_equal 0.49, @game_teams.average_win_percentage("6")
  end

  def test_best_season
    assert_equal "20132014", @game_teams.best_season("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @game_teams.fewest_goals_scored("18")
  end
end
