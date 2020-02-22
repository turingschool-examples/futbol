require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/team_stats'

class TeamStatsTest < Minitest::Test

  def setup
    @team_stats = TeamStats.new("./data/teams.csv", Team)
    @team = @team_stats.teams[1]
  end

  def test_it_can_exist
    assert_instance_of TeamStats, @team_stats
  end

  def test_attributes_for_instance_of_team_within_team_stats
    assert_equal 4, @team.team_id
    assert_equal 16, @team.franchiseid
    assert_equal "Chicago Fire", @team.teamname
  end

  def test_it_can_return_count_of_teams
    assert_equal 32, @team_stats.count_of_teams
  end

  def test_team_stats_find_name
    assert_equal "Chicago Fire", @team_stats.find_name(4)
  end  
end
