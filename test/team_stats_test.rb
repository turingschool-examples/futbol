require_relative 'test_helper'
require './lib/team_stats'

class TeamStatsTest < Minitest::Test

  def setup
    @team_stats = TeamStats.new("./data/teams.csv", TeamStats)
    @team = @team_stats.teams[1]
  end

  def test_it_can_exist
    assert_instance_of TeamStats, @team_stats
  end

end
