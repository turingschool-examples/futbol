require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @new_team = Team.new ({
      :team_id => 1,
      :franchiseId => 23,
      :teamName => "Atlanta United",
      :abbreviation => "ATL",
      # :Stadium => "Mercedes-Benz Stadium"
      })

      Team.from_csv("./test/fixtures/teams.csv")
      @team = Team.all[0]
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

end
