require_relative 'test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team = Team.new({
          team_id: 2015030226,
          franchise_id: 20152016,
          team_name: "Postseason"
        })
  end

  def test_it_exists
    assert_instance_of Team, @team
  end


end
