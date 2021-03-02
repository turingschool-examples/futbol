require './test/test_helper'
class GameTeamManagerTest < Minitest::Test
  def setup
    @game_team_data = GameTeamManager.new("data/fixture/game_teams_dummy.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_data
  end

  def test_make_goals_by_team_hash
    expected = {
      "3"=>[2, 2, 1, 2, 1],
      "6"=>[3, 3, 2, 3]
    }

    assert_equal expected, @game_team_data.make_goals_by_team_hash
  end

  def test_average_goals_by_team_hash
    expected = {
      "3"=>1.6,
      "6"=>2.75
    }

    assert_equal expected, @game_team_data.average_goals_by_team_hash
  end

  def test_teams_max_average_goals
    assert_equal "6", @game_team_data.teams_max_average_goals
  end
end
