require './test/setup'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @game_team = GameTeam.new({
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2"
      })
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_attributes
    assert_equal "2012030221", @game_team.game_id
    assert_equal 3, @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "LOSS", @game_team.result
    assert_equal "OT", @game_team.settled_in
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
  end

end
