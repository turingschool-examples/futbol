require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def test_it_exists
    data = CSV.read('./data/game_teams_dummy.csv', headers:true)
    game_teams = GameTeam.new(data[0], "manager")

    assert_instance_of GameTeam, game_team
    assert_instance_of CSV::Table, data
  end
end
