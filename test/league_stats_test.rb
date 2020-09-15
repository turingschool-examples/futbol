require_relative 'test_helper'

class LeagueStatsTest < Minitest::Test
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
  @league_stats = LeagueStats.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_count_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_best_offense_stats
    assert_equal 54, @league_stats.best_offense_stats
  end

  def test_team_with_best_offense
    assert_equal 'Reign FC', @league_stats.best_offense
  end

  def test_worst_offense_stats
    assert_equal 7, @league_stats.worst_offense_stats
  end

  def test_worst_offense
    assert_equal 'Utah Royals FC', @league_stats.worst_offense
  end

  def test_team_highest_away_goals
    assert_equal 6, @league_stats.team_highest_away_goals
  end

  def test_highest_scoring_visitor
    assert_equal 'FC Dallas', @league_stats.highest_scoring_visitor
  end

  def test_team_lowest_away_goals
    assert_equal 27, @league_stats.team_lowest_away_goals
  end

  def test_team_highest_home_goals
    assert_equal 54, @league_stats.team_highest_home_goals
  end

  def test_highest_scoring_home_team
    assert_equal 'Reign FC', @league_stats.highest_scoring_home_team
  end

  def test_team_lowest_home_goals
    assert_equal 7, @league_stats.team_lowest_home_goals
  end

  def test_lowest_scoring_visitor
    assert_equal 'San Jose Earthquakes', @league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal 'Utah Royals FC', @league_stats.lowest_scoring_home_team
  end
end
