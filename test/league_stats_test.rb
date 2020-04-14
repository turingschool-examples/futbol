require './test/test_helper'
require './lib/league_stats'

class LeagueStatsTest < MiniTest::Test

  def setup
    @league_stats = LeagueStats.new({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_has_attributes
    assert_instance_of Game, LeagueStats.games.first
    assert_instance_of Team, LeagueStats.teams.first
    assert_instance_of GameTeam, LeagueStats.game_teams.first
  end

  def test_count_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_best_offense
    @league_stats.stubs(:average_goals_by_team).returns(1)
    @league_stats.stubs(:average_goals_by_team).with("1").returns(2)
    assert_equal 'Atlanta United', @league_stats.best_offense
  end

  def test_worst_offense
    @league_stats.stubs(:average_goals_by_team).returns(2)
    @league_stats.stubs(:average_goals_by_team).with("2").returns(1)
    assert_equal 'Seattle Sounders FC', @league_stats.worst_offense
  end

  def test_highest_scoring_visitor
    @league_stats.stubs(:average_goals_by_team).returns(1)
    @league_stats.stubs(:average_goals_by_team).with("24", "away").returns(2)
    assert_equal 'Real Salt Lake', @league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    @league_stats.stubs(:average_goals_by_team).returns(1)
    @league_stats.stubs(:average_goals_by_team).with("6", "home").returns(2)
    assert_equal 'FC Dallas', @league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    @league_stats.stubs(:average_goals_by_team).returns(2)
    @league_stats.stubs(:average_goals_by_team).with("23", "away").returns(1)
    assert_equal 'Montreal Impact', @league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    @league_stats.stubs(:average_goals_by_team).returns(2)
    @league_stats.stubs(:average_goals_by_team).with("19", "home").returns(1)
    assert_equal 'Philadelphia Union', @league_stats.lowest_scoring_home_team
  end


end
