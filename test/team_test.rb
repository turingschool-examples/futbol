require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team_mananger'
require './lib/team'
require 'pry';
require 'mocha/minitest'

class TeamTest < Minitest::Test
  def setup
    data = {
            'team_id'      => '30'
            'franchiseId'  => '37'
            'teamName'     => 'Orlando City SC'
            'abbreviation' => 'ORL'
            'Stadium'      => 'Exploria Stadium'
            'link'         => '/api/v1/teams/30'
    }

    manager = mock('TeamManager')
    @team = Team.new (data, manager)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
