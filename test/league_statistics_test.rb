require './lib/stat_tracker'
require './lib/league_statistics'
require './test/test_helper'

class LeagueStatisticsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(locations)
    @league_statistics = LeagueStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_can_count_number_of_teams
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_it_knows_highest_average_goals_scored_across_season
      #
    	# Name of the team with the highest average
      # number of goals scored per game across all seasons.
    assert_equal 'FC Dallas', @league_statistics.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
      #
      # Name of the team with the highest average
      # number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @league_statistics.worst_offense
  end

  def test_it_knows_highest_average_away
    	# Name of the team with the highest average score
      # per game across all seasons when they are away.
    assert_equal 'Real Salt Lake', @league_statistics.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
      # Name of the team with the highest average score
      # per game across all seasons when they are away.
    assert_equal 'Real Salt Lake', @league_statistics.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    	# Name of the team with the highest average score
      # per game across all seasons when they are away.
    assert_equal 'Sporting Kansas City', @league_statistics.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
      # Name of the team with the highest average score
      # per game across all seasons when they are away.
    assert_equal 'Sporting Kansas City', @league_statistics.lowest_scoring_home_team
  end
end
