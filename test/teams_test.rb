require "./test/test_helper"


class TeamsTest < MiniTest::Test
  def setup
    row = {
:team_id => 1,
:franchiseid => 2,
:teamname => "Atlanta United",
:abbreviation => "ATL",
:stadium => "Mercedes-Benz Stadium",
:link => "/api/v1/teams/1"
          }

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
    stat_tracker = StatTracker.new(locations)
    stat_tracker.teams
    @teams = Teams.new(row)
  end

  def test_it_exists
    assert_instance_of Teams, @teams
  end

  def test_it_has_attributes
    assert_equal 1, @teams.team_id
    assert_equal 2, @teams.franchiseid
    assert_equal "Atlanta United", @teams.teamname
    assert_equal "ATL", @teams.abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams.stadium
    assert_equal "/api/v1/teams/1", @teams.link
  end


end
