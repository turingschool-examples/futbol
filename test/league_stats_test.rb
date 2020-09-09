require './test/test_helper'
require './lib/league_stats'
require './lib/stat_tracker'

class LeagueStatsTest <Minitest::Test
  def setup
    @game_path = './fixtures/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    @stat_tracker.extend(LeagueStats)
  end

  def test_count_of_teams
    assert_equal 26, @stat_tracker.count_of_teams
  end

  def test_with_best_offense
    assert_equal "Atlanta United", @stat_tracker.best_offense
  end

  def test_with_worst_offense
    assert_equal "Vancouver Whitecaps FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "Minnesota United FC", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Philadelphia Union", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Vancouver Whitecaps FC", @stat_tracker.lowest_scoring_home_team
  end

end
