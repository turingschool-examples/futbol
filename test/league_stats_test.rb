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

end
