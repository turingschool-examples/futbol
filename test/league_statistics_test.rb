require './lib/stat_tracker'
require './lib/league_statistics'
require './test/test_helper'

class LeagueStatisticsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
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
    assert_equal 'FC Dallas', @stat_tracker.best_offense
  end
end
