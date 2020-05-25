require './test/helper_test'
require './lib/game_teams'

class GameTeamTest < Minitest::Test
  def setup
  @game = {
    game_id: "2012030223",
    team_id: "6",
    hoa: "away",
    result: "WIN",
    settled_in: "REG",
    head_coach: "Claude Julien",
    goals: "2",
    shots: "8",
    tackles: "28"
  }

  @game_team = GameTeam.new(@game)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_game_team_info_attributes
    assert_equal "2012030223", @game_team.game_id
    assert_equal "6", @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "WIN", @game_team.result
    assert_equal "REG", @game_team.settled_in
    assert_equal "Claude Julien", @game_team.head_coach
    assert_equal "2", @game_team.goals
    assert_equal "8", @game_team.shots
    assert_equal "28", @game_team.tackles
  end
end
