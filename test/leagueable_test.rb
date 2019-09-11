require './test/test_helper'
require './lib/stat_tracker'
require './lib/leagueable'

class LeagueableTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  # Total number of teams in the data. Return: Int
  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  # Name of the team with the highest average number of goals scored per game across all seasons. Return: String
  def test_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  # Name of the team with the lowest average number of goals scored per game across all seasons. Return: String
  def test_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  # Name of the team with the lowest average number of goals allowed per game across all seasons. Return: String
  def test_best_defense
    assert_equal "FC Cincinnati", @stat_tracker.best_defense
  end

  # Name of the team with the highest average number of goals allowed per game across all seasons. Return: String
  def test_worst_defense
    assert_equal "Columbus Crew SC", @stat_tracker.worst_defense
  end

  # Name of the team with the highest average score per game across all seasons when they are away. Return: String
  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  # Name of the team with the highest average score per game across all seasons when they are home. Return: String
  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  # Name of the team with the lowest average score per game across all seasons when they are a visitor. Return: String
  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  # Name of the team with the lowest average score per game across all seasons when they are at home. Return: String
  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  # Name of the team with the highest win percentage across all seasons. Return: String
  def test_winningest_team
    assert_equal "Reign FC", @stat_tracker.winningest_team
  end

  # Name of the team with biggest difference between home and away win percentages. Return: String
  def test_best_fans
    assert_equal "San Jose Earthquakes", @stat_tracker.best_fans
  end

  # List of names of all teams with better away records than home records. Return: Array
  def test_worst_fans
    assert_equal ["Houston Dynamo", "Utah Royals FC"], @stat_tracker.worst_fans
  end

end
