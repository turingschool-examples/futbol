require './test/test_helper'
require './lib/stats'

class StatsTest < MiniTest::Test

  def setup
    stats = Stats.new({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of Stats, stats
  end

  def test_has_attributes
    assert_instance_of Game, stats.games.first
    assert_instance_of Team, stats.teams.first
    assert_instance_of GameTeam, stats.game_teams.first
  end

  def test_find_team_by_id
    assert_equal 'Reign FC', @stat_tracker.team_by_id("54").team_name
  end

  def test_all_games_by_team
    assert_equal 5, @stat_tracker.all_games_by_team("30").length
    assert_instance_of GameTeam, @stat_tracker.all_games_by_team("30").first
    assert_instance_of GameTeam, @stat_tracker.all_games_by_team("30").last
  end

end
