require_relative 'test_helper'

class GameTeamTest < Minitest::Test

  def setup
    game_team_hash = {
                      game_id: 2012030222,
                      team_id: 3,
                      hoa: 'away',
                      result: 'LOSS',
                      settled_in: 'REG',
                      head_coach: 'John Tortorella',
                      goals: 2,
                      shots: 9,
                      tackles: 33,
                      pim: 11,
                      powerPlayOpportunities: 5,
                      powerPlayGoals: 0,
                      faceOffWinPercentage: 51.7,
                      giveaways: 1,
                      takeaways: 4
                    }

    @game_team_1 = GameTeam.new(game_team_hash)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team_1
  end

  def test_it_initializes_with_attributes
    assert_equal 2012030222, @game_team_1.game_id
    assert_equal 3, @game_team_1.team_id
    assert_equal 'away', @game_team_1.hoa
    assert_equal 'LOSS', @game_team_1.result
    assert_equal 'REG', @game_team_1.settled_in
    assert_equal 'John Tortorella', @game_team_1.head_coach
    assert_equal 2, @game_team_1.goals
    assert_equal 9, @game_team_1.shots
    assert_equal 33, @game_team_1.tackles
    assert_equal 11, @game_team_1.pim
    assert_equal 5, @game_team_1.powerPlayOpportunities
    assert_equal 0, @game_team_1.powerPlayGoals
    assert_equal 51.7, @game_team_1.faceOffWinPercentage
    assert_equal 1, @game_team_1.giveaways
    assert_equal 4, @game_team_1.takeaways
  end
end
