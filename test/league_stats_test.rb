require_relative 'test_helper'
require './lib/game_statistics'
require './lib/stat_tracker'
require './lib/league_stats'

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

    @stat_tracker_location = StatTracker.from_csv(locations)
    @teams_stats = @stat_tracker_location.teams_stats
    @stat_tracker = @stat_tracker_location.game_stats
    @stat_game_teams_tracker = @stat_tracker_location.game_teams_stats
    @game_statistics = GameStatistics.new(@stat_tracker, @stat_game_teams_tracker)
    @league_stats = LeagueStatistics.new(@teams_stats)
  end

  def test_it_exits
    assert_instance_of LeagueStatistics, @league_stats
  end

  def test_attributes
    assert_equal 32, @league_stats.teams_data.length
  end

  def test_count_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end
end
