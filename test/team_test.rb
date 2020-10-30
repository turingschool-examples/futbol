require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/team'
require './lib/teams_repo'

class TeamTest < Minitest::Test
  def setup

    row = CSV.readlines('./data/teams.csv', headers: :true, header_converters: :symbol)[0]
    @parent = mock('teams_repo')
    @team1 = Team.new(row, @parent)
  end

  def test_it_exists_and_has_attributes

    assert_equal 1, @team1.team_id
    assert_equal 23, @team1.franchise_id
    assert_equal "Atlanta United", @team1.team_name
    assert_equal "ATL", @team1.abbreviation
    assert_equal "Mercedes-Benz Stadium", @team1.stadium
    assert mock(), @team1.parent
  end

  def test_count_of_teams
    assert_equal 32, @game_teams_repo.count_of_teams
  end
end
