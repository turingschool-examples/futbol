require './test/test_helper'
require './lib/league_stats'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_team'
require './lib/team'

class LeagueStatsTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
    @league_stats = @stat_tracker.league_stats
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_has_attributes
    assert_instance_of Game, @league_stats.games.first
    assert_instance_of Team, @league_stats.teams.first
    assert_instance_of GameTeam, @league_stats.game_teams.first
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

  def test_it_can_find_average_goals_by_team
    assert_equal 2.4, @league_stats.average_goals_by_team("52")
  end

  def test_total_games_and_goals_by_team
    assert_equal [7, 5], @league_stats.total_games_and_goals_by_team("30", nil)
  end

  def test_add_goals_and_games
    goals_games = [0, 0]
    game_team = mock
    game_team.stubs(:goals).returns(2)
    @league_stats.add_goals_and_games(goals_games, game_team)
    assert_equal [2, 1], goals_games
  end

  def test_it_can_find_unique_team_id
    assert_equal ["30", "52", "19", "23", "24", "4", "29", "12", "6", "17", "1", "2"], @league_stats.unique_team_ids
  end


end
