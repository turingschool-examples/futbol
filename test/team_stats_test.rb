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
      "link" => "/api/v1/teams/1"}), TeamStats.team_info("1")
  end
end
