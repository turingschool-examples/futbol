require "./lib/game_team"
require "./test/test_helper"

class GameTeamTest < Minitest::Test
  def setup
    GameTeam.from_csv
  end

  def test_it_can_read_from_csv
    assert_equal 106, GameTeam.all_game_teams.count
  end

  def test_it_has_attributes
    gt_1 = GameTeam.all_game_teams[0]

    assert_equal 2014020006, gt_1.game_id
    assert_equal 1, gt_1.team_id
    assert_equal "away", gt_1.hoa
    assert_equal "WIN", gt_1.result
    assert_equal "REG", gt_1.settled_in
    assert_equal "Peter DeBoer", gt_1.head_coach
    assert_equal 4, gt_1.goals
    assert_equal 6, gt_1.shots
    assert_equal 36, gt_1.tackles
  end
end
