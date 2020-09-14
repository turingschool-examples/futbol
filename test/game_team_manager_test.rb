require './test/test_helper'
require './lib/game_team_manager'
require './lib/stat_tracker'

class GameTeamManagerTest < Minitest::Test
  def setup
    @game_path = './fixtures/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams_league_stats.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_score_average_per_team
    stat_tracker = mock('stat tracker object')
    game_teams_manager = GameTeamManager.new(@locations, stat_tracker)
    expected = 2.39
    assert_equal expected, game_teams_manager.goal_avg_per_team('5', '')
    expected = 2.25
    assert_equal expected, game_teams_manager.goal_avg_per_team('5', 'home')
    expected = 2.5
    assert_equal expected, game_teams_manager.goal_avg_per_team('5', 'away')
  end

  def test_with_best_offense
    assert_equal "DC United", @stat_tracker.best_offense
  end

  def test_with_worst_offense
    assert_equal "Houston Dash", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "New England Revolution", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "DC United", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "New York City FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_home_team
  end
end
