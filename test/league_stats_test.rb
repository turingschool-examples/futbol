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

    @stat_tracker = StatTracker.from_csv(locations)
    @raw_teams_stats = @stat_tracker.teams_stats
    @raw_game_stats = @stat_tracker.game_stats
    @raw_game_teams_stats = @stat_tracker.game_teams_stats
    @game_statistics = GameStatistics.new(@raw_game_stats, @raw_game_teams_stats)
    @league_stats = LeagueStatistics.new(@raw_teams_stats, @game_statistics)
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

  def test_group_by_team_id
    assert_equal 32, @league_stats.group_by_team_id.keys.count
  end

  def test_team_id_and_average_goals
    assert_equal 32, @league_stats.team_id_and_average_goals.count
  end

  def test_best_offense_stats
    assert_equal 54, @league_stats.best_offense_stats
  end

  def test_worst_offense_stats
    assert_equal 7, @league_stats.worst_offense_stats
  end

  def test_team_with_best_offense
    assert_equal 'Reign FC', @league_stats.best_offense
  end

  def test_worst_offense
    assert_equal 'Utah Royals FC', @league_stats.worst_offense
  end

  def test_id_and_average_away_goals
    assert_equal 32, @league_stats.team_id_and_average_away_goals.count
  end

  def test_team_away_goals
    assert_equal 6, @league_stats.team_away_goals
  end

  def test_highest_scoring_visitor
    assert_equal 'FC Dallas', @league_stats.highest_scoring_visitor
  end
end
