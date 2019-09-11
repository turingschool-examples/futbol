require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @sample_data = '2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7'
    @game_team = GameTeam.new(@sample_data)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_initialization
    skip
    assert_equal 2012030221, @game_team.game_id
    assert_equal 3, @game_team.team_id
    assert_equal 'away', @game_team.hoa
    assert_equal 'LOSS', @game_team.result
    assert_equal 'OT', @game_team.settled_in
    assert_equal 'John Tortorella', @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
    assert_equal '8', @game_team.pim
    assert_equal '3', @game_team.powerPlayOpportunities
    assert_equal '0', @game_team.powerPlayGoals
    assert_equal '44.8', @game_team.faceOffWinPercentage
    assert_equal '17', @game_team.giveaways
    assert_equal '7', @game_team.takeaways
  end

end
