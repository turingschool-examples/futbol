require './test/test_helper'
require './lib/game_teams_methods'

class GameTeamsMethodsTest < Minitest::Test
  def test_it_exists
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_instance_of GameTeamsMethods, game_teams_methods

    assert_equal './data/game_teams.csv', game_teams_methods.game_teams
  end

  def test_generates_table
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    expected = CSV.parse(File.read(game_teams), headers: true)

    assert_equal expected, game_teams_methods.create_table(game_teams)

    assert_equal expected, game_teams_methods.game_teams_table
  end
end
