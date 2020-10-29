require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require './lib/object_data'
require './lib/stat_tracker'

class LeagueStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @object_data ||= ObjectData.new(@stat_tracker)
    @league_statistics = LeagueStatistics.new
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_count_of_teams
    assert_equal 32, @league_statistics.count_of_teams(@object_data.teams)
  end

  



  # best_offense	Name of the team with the highest average
  # number of goals scored per game across all seasons.	String
# worst_offense	Name of the team with the lowest average number
#  of goals scored per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average
# score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average
# score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average
# score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average
# score per game across all seasons when they are at home.
end
