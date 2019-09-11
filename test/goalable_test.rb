require './test/test_helper'
require './lib/stat_tracker'
require './lib/goalable'

class GoalableTest < Minitest::Test

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

  ### From Leagueable_Test ###

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

  ### From Teamable_Test ###

  #Highest number of goals a particular team has scored in a single game.	Integer
  #BB
  def test_most_goals_scored
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  #Lowest numer of goals a particular team has scored in a single game.	Integer
  #BB
  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

end
