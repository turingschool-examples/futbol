require './test/test_helper'

class GameStatsTest < Minitest::Test
  def setup
    @game = './test/game_stats_dummy.csv'
  end
#should we account for two teams per game id and return arrays?
  def test_it_exists_and_has_attributes
    assert_instance_of GameStats, @game7
    assert_equal 2015030133, @game7.game_id
    assert_equal 4, @game7.team_id
    assert_equal "home", @game7.hoa
    assert_equal "LOSS", @game7.result
    assert_equal "REG", @game7.settled_in
    assert_equal "Dave Hakstol", @game7.head_coach
    assert_equal 1, @game7.goals
    assert_equal 8, @game7.shots
    assert_equal 45, @game7.tackles
    assert_equal 53, @game7.pim
    assert_equal 5, @game7.powerPlayOpportunities
    assert_equal 0, @game7.powerPlayGoals
    assert_equal 55.9, @game7.faceOffWinPercentage
    assert_equal 17, @game7.giveaways
    assert_equal 2, @game7.takeaways
  end
end
