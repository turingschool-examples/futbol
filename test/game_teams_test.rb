require_relative 'test_helper'
require_relative '../lib/game_teams'

class GameTeamsTest < Minitest::Test

  def setup
    @line_2 = GameTeams.new("2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7")
  end

  def test_it_exists
    assert_instance_of GameTeams, @line_2
  end


  def test_attributes
    assert_equal '2012030221', @line_2.game_id
    assert_equal '3', @line_2.team_id
    assert_equal "away", @line_2.hoa
    assert_equal "LOSS", @line_2.result
    assert_equal "OT", @line_2.settled_in
    assert_equal "John Tortorella", @line_2.head_coach
    assert_equal 2, @line_2.goals
    assert_equal 8, @line_2.shots
    assert_equal 44, @line_2.tackles
    assert_equal 8, @line_2.pim
    assert_equal 3, @line_2.powerPlayOpportunities
    assert_equal 0, @line_2.powerPlayGoals
    assert_equal 44.8, @line_2.faceOffWinPercentage
    assert_equal 17, @line_2.giveaways
    assert_equal 7, @line_2.takeaways
  end

end
