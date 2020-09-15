require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/team_manager'
require './test/test_helper'

class TeamTest < Minitest::Test
  def test_it_exists
    path = './data/teams.csv'
    team = Team.new(path, nil)

    assert_instance_of Team, team
  end
end
