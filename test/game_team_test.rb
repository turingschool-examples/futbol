require_relative 'test_helper'

class GameTeamTestTest < Minitest::Test

  def setup
    @game_team = GameTeam.new({
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "8",
      tackles: "44",
      pim: "8",
      powerplayopportunities: "3",
      powerplaygoals: "0",
      faceoffwinpercentage: "44.8",
      giveaways: "17",
      takeaways: "7"
      })
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_attributes
    assert_equal "2012030221", @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "LOSS", @game_team.result
    assert_equal "OT", @game_team.settled_in
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
    assert_equal 8, @game_team.pim
    assert_equal 3, @game_team.powerplayopportunities
    assert_equal 0, @game_team.powerplaygoals
    assert_equal 44.8, @game_team.faceoffwinpercentage
    assert_equal 17, @game_team.giveaways
    assert_equal 7, @game_team.takeaways
  end
end
