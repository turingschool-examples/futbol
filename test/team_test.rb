require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
#require './data/teams_dummy'
require './lib/team'

class TeamTest < Minitest::Test
  def test_it_exists

    data = CSV.read('./data/teams_dummy.csv', headers:true)
    team = Team.new(data[0], "manager")
    binding.pry
    assert_instance_of Team, team
    assert_instance_of CSV::Table, data
  end


end
