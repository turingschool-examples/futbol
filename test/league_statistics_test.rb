require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_statistics'
require './lib/team'
require './lib/game'
require './lib/game_team'


class Test < Minitest::Test
  def setup
    game_path = './test/fixtures/games_truncated.csv'
    team_path = './test/fixtures/teams_truncated.csv'
    game_teams_path = './test/fixtures/game_teams_truncated.csv'

    @stat_tracker = StatTracker.from_csv(game_path, team_path, game_teams_path)
  end

  def test_it_can_count_teams
    assert_equal 5, @league.count_of_teams
  end

  def test_it_can_tell_best_offense
    assert_equal "FC Dallas", @league.best_offense
  end

  def test_it_can_tell_worst_offense
    assert_equal "", @league.worst_offense
  end

  def test_it_can_tell_best_defense
    assert_equal "", @league.best_defense
  end

  def test_it_can_tell_worst_defense
    assert_equal "", @league.worst_defense
  end

  def test_it_can_tell_highest_scoring_visitor
    assert_equal "", @league.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "", @league.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "", @league.lowest_scoring_visitor
  end

  def test_it_can_tell_lowest_scoring_home_team
    assert_equal "", @league.lowest_scoring_home_team
  end

  def test_it_can_tell_winningest_team
    assert_equal "", @league.winningest_team
  end

  def test_it_can_tell_best_fans
    assert_equal "", @league.best_fans
  end

  def test_it_can_tell_worst_fans
    assert_equal [], @league.worst_fans
  end
end
