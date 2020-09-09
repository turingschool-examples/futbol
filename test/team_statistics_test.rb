require_relative 'test_helper'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat = StatTracker.new
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    team_statistics = TeamStatistics.new(stat_tracker, @stat)

    assert_instance_of TeamStatistics, team_statistics
  end

  def test_team_info
    stat_tracker = StatTracker.from_csv(@locations)
    team_statistics = TeamStatistics.new(stat_tracker, @stat)
    team_statistics.team_info
    expected = ["PHI", "18", "/api/v1/teams/19", 19, "Philadelphia Union"]

    assert_equal expected, @stat.team_info_stat[19]
  end

  def test_total_games_played_per_season
    stat_tracker = StatTracker.from_csv(@locations)
    team_statistics = TeamStatistics.new(stat_tracker, @stat)

    assert_equal 60, team_statistics.total_games_played_per_season_by_team["20122013"][3]
  end

  def test_how_many_games_each_team_won_per_season
    stat_tracker = StatTracker.from_csv(@locations)
    team_statistics = TeamStatistics.new(stat_tracker, @stat)
    
  end

end
