require './test/test_helper'
require './lib/stats'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatsTest < MiniTest::Test

  def setup
      Game.from_csv("./test/fixtures/games_fixture.csv")
      Team.from_csv("./data/teams.csv")
      GameTeam.from_csv("./test/fixtures/games_teams_fixture.csv")
      @stats = Stats.new(Game.all, Team.all, GameTeam.all)
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
