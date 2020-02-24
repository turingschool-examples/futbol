require "./test/test_helper"
require "mocha/minitest"
require "./lib/team_collection"

class TeamCollectionTest < Minitest::Test

  def test_it_exists
    TeamCollection.stubs(:create_teams).returns(Array.new(32, mock('team')))
    stubbed_team_collection = TeamCollection.new("./data/teams.csv")
    assert_instance_of TeamCollection, stubbed_team_collection
  end

  def test_it_has_attributes
    TeamCollection.stubs(:create_teams).returns(Array.new(32, mock('team')))
    stubbed_team_collection = TeamCollection.new("./data/teams.csv")

    assert_instance_of Array, stubbed_team_collection.teams
    assert_equal 32, stubbed_team_collection.teams.length
  end

  def test_csv_loads
    team_collection = TeamCollection.new("./data/teams.csv")

    team_a = team_collection.teams.first
    team_z = team_collection.teams.last


    assert_equal 1,                       team_a.team_id
    assert_equal 23,                      team_a.franchiseId
    assert_equal "Atlanta United",        team_a.teamName
    assert_equal "ATL",                   team_a.abbreviation
    assert_equal "Mercedes-Benz Stadium", team_a.stadium
    assert_equal "/api/v1/teams/1",       team_a.link

    assert_equal 53,                      team_z.team_id
    assert_equal 28,                      team_z.franchiseId
    assert_equal "Columbus Crew SC",      team_z.teamName
    assert_equal "CCS",                   team_z.abbreviation
    assert_equal "Mapfre Stadium",        team_z.stadium
    assert_equal "/api/v1/teams/53",      team_z.link

  end

  def test_can_find_team_by_id

    stubbed_team_collection = TeamCollection.new("./data/teams.csv")

    specific_team = stubbed_team_collection.find_team_by_id(53)

    assert_equal 53,                      specific_team.team_id
    assert_equal 28,                      specific_team.franchiseId
    assert_equal "Columbus Crew SC",      specific_team.teamName
    assert_equal "CCS",                   specific_team.abbreviation
    assert_equal "Mapfre Stadium",        specific_team.stadium
    assert_equal "/api/v1/teams/53",      specific_team.link

  end

end
