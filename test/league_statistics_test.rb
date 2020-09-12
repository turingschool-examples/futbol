require_relative 'test_helper'

class LeagueStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    @stat_tracker ||= StatTracker.from_csv({games: game_path, teams: team_path})
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

end
# best_offense	Name of the team with the highest average number of goals
#scored per game across all seasons.	String


# worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
