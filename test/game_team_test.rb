require_relative './test_helper'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @gameteam = GameTeam.new("2012030221","6","home","WIN","OT",
      "Claude Julien","3","12","51","6","4","1","55.2","4","5")
  end

  def test_it_exists_and_has_attributes

    assert_instance_of GameTeam, @gameteam
    assert_equal 2012030221, @gameteam.game_id
    assert_equal 6, @gameteam.team_id
    assert_equal "home", @gameteam.hoa
    assert_equal "WIN", @gameteam.result
    assert_equal "OT", @gameteam.settled_in
    assert_equal "Claude Julien", @gameteam.head_coach
    assert_equal 3, @gameteam.goals
    assert_equal 12, @gameteam.shots
    assert_equal 51, @gameteam.tackles
    assert_equal 6, @gameteam.pim
    assert_equal 4, @gameteam.powerPlayOpportunities
    assert_equal 1, @gameteam.powerPlayGoals
    assert_equal 55.2, @gameteam.faceOffWinPercentage
    assert_equal 4, @gameteam.giveaways
    assert_equal 5, @gameteam.takeaways
  end
end
