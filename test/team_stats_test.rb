require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/team_stats'

class TeamStatsTest < Minitest::Test

  def setup
    @team_stats = TeamStats.new("./data/teams.csv", TeamStats)
    @team = @team_stats.teams[1]
  end

  def test_it_can_exist
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_can_find_team_name
    assert_equal 'Chicago Red Stars', @team_stats.find_name(25)
    assert_equal 'New York Red Bulls', @team_stats.find_name(8)
  end

end
