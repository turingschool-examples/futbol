require "./test/test_helper"

require "pry"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"

class TeamTest < Minitest::Test

  def setup
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Game)

    @team1 = Team.new({
      team_id: 1,
      franchise_id: 23,
      team_name: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1"
      })
  end

  def test_it_exists
    team = Team.new({})
    assert_instance_of Team, team
  end

  def test_it_has_attributes
    assert_equal 1, @team1.team_id
    assert_equal 23, @team1.franchise_id
    assert_equal "Atlanta United", @team1.team_name
    assert_equal "ATL", @team1.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team1.stadium
    assert_equal "/api/v1/teams/1", @team1.link
  end

end
