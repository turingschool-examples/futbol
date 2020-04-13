require './test/test_helper'
require './lib/stats'

class StatsTest < MiniTest::Test

  def setup
    @stats = Stats.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of Stats, @stats
  end

  def test_has_attributes
    assert_instance_of Game, @stats.games.first
    assert_instance_of Team, @stats.teams.first
    assert_instance_of GameTeam, @stats.game_teams.first
  end

end
