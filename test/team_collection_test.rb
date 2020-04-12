require_relative 'test_helper'

class TeamCollectionTest < Minitest::Test
  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @team = @team_collection.teams[21]
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @team_collection.teams
    assert_equal 32, @team_collection.teams.length
  end

  def test_it_can_create_teams_from_csv
    assert_instance_of Team, @team
    assert_equal "VAN", @team.abbreviation
    assert_equal 27, @team.franchiseid
    assert_equal "/api/v1/teams/21", @team.link
    assert_equal 21, @team.team_id
    assert_equal "Vancouver Whitecaps FC", @team.teamname
  end

  def test_count_of_teams
    assert_equal 32, @team_collection.count_of_teams
  end

  def find(team_id_number)
    @teams.find {|team| team.team_id == team_id_number}
  end

  def test_it_can_find_team_info_using_team_id
    expected = {
      :team_id => 1,
      :franchiseid => 23,
      :teamname => "Atlanta United",
      :abbreviation => "ATL",
      :link => "/api/v1/teams/1"
    }
    assert_equal expected, @team_collection.team_info(1)
  end
end
