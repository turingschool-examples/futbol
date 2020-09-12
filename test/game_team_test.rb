require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def test_it_exists
    data = CSV.read('./data/game_teams_dummy.csv', headers:true)
    game_team = GameTeam.new(data[0], "manager")

    assert_instance_of GameTeam, game_team
    assert_instance_of CSV::Table, data
  end

  def test_it_has_attributes
    data = CSV.read('./data/game_teams_dummy.csv', headers:true)
    game_team = GameTeam.new(data[0], "manager")

    assert_equal "2012030221", game_team.game_id
    assert_equal "3", game_team.team_id
    assert_equal "LOSS", game_team.result
    assert_equal "John Tortorella", game_team.head_coach
    assert_equal 2, game_team.goals
    assert_equal 8, game_team.shots
    assert_equal 44, game_team.tackles
  end
end
