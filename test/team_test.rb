require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/stat_tracker'
require './lib/team'
#

class TeamTest < Minitest::Test
  def setup
    # file_path = "./data/games.csv"
    file_path = "./data/teams.csv"
    @teams = Team.from_csv(file_path)

    @base_team = Team.new({
      :team_id => 4,
      :franchiseid => 16,
      :teamname => "Chicago Fire",
      :abbreviation => "CHI",
      :stadium => "SeatGeek Stadium",
      :link => "/api/v1/teams/4",
      })
  end

  def test_it_exists
    assert_instance_of Team, @base_team
    assert_instance_of Team, @teams.first
  end

  def test_it_returns_list_of_teams
    assert_instance_of Array, Team.all
    assert_equal 32, Team.all.length
    assert_instance_of Team, Team.all.first
  end

  def test_it_returns_attributes
    assert_equal 4 , @base_team.team_id
    # binding.pry
    assert_equal 16 , @base_team.franchise_id
    assert_equal "Chicago Fire" , @base_team.team_name
    assert_equal "CHI" , @base_team.abbreviation
    assert_equal "SeatGeek Stadium" , @base_team.stadium
    assert_equal "/api/v1/teams/4" , @base_team.link
  end

  def test_count_of_teams
    assert_equal 32, @teams.count_of_teams
  end

end #final
