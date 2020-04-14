require './test/test_helper'
require './lib/team_stats'

class TeamStatsTest < MiniTest::Test

  def setup
    @team_stats = TeamStats.new({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_finds_team_info
    assert_equal ({"team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => "/api/v1/teams/1"}), @team_stats.team_info("1")
  end

  def test_it_can_find_teams_best_season
    assert_equal '20172018', @team_stats.best_season('52')
  end

  def test_it_can_find_tams_worst_season
    assert_equal '20172018', @team_stats.worst_season('52')
  end

end
