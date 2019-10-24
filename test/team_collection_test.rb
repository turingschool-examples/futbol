require './test/test_helper'
require './lib/team_collection'

class TeamsCollectionTest < Minitest::Test

  def setup
    @total_teams = TeamCollection.new("./data/teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @total_teams
  end

  def test_it_has_total_teams
    @total_teams.create_teams('./data/teams_sample.csv')
    assert_equal 3, @total_teams.total_teams.length
  end
end
