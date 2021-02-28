require './test/test_helper'

class GameTeamTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({game_id: 2015030133,
    team_id: 4,
    hoa: "home",
    result: "LOSS",
    settled_in: "REG",
    head_coach: "Dave Hakstol",
    goals: 1,
    shots: 8,
    tackles: 45,
    pim: 53,
    powerplayopportunities: 5,
    powerplaygoals: 0,
    faceoffwinpercentage: 55.9,
    giveaways: 17,
    takeaways: 2})
  end
#should we account for two teams per game id and return arrays?
  def test_it_exists_and_has_attributes
    assert_instance_of GameTeam, @game_team
    assert_equal 2015030133, @game_team.game_id
    assert_equal 4, @game_team.team_id
    assert_equal "home", @game_team.hoa
    assert_equal "LOSS", @game_team.result
    assert_equal "REG", @game_team.settled_in
    assert_equal "Dave Hakstol", @game_team.head_coach
    assert_equal 1, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 45, @game_team.tackles
    assert_equal 53, @game_team.pim
    assert_equal 5, @game_team.powerplayopportunities
    assert_equal 0, @game_team.powerplaygoals
    assert_equal 55.9, @game_team.faceoffwinpercentage
    assert_equal 17, @game_team.giveaways
    assert_equal 2, @game_team.takeaways
  end
end
