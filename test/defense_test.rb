require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/defense'

class DefenseTest < Minitest::Test

  def setup
    Defense.new
    @team_path = './test/dummy/teams_trunc.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
  end

  def test_it_can_return_best_defense
    assert_equal "Portland Timbers", Defense.best_defense
  end

  def test_it_can_return_worst_defense
    assert_equal "New York City FC", Defense.worst_defense
  end

  def test_it_can_get_team_name_from_id
    assert_equal "New York City FC", Defense.get_team_name_from_id("9")
  end
end
