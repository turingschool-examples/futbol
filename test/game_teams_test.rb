require "./test/test_helper"

class GameTeamTest < Minitest::Test
  def setup
    @data =   { game_id: '2012030221',
              team_id: '3',
              HoA: 'away',
              result: 'LOSS',
              settled_in: 'OT',
              head_coach: 'John Tortorella',
              goals: '2',
              shots: '8',
              tackles: '44',
              pim: '8',
              powerPlayOpportunities: '3',
              powerPlayGoals: '0',
              faceOffWinPercentage: '44.8',
              giveaways: '17',
              takeaways: '7'}

    @team = GameTeam.new(@data)
  end

  def test_it_exists
    assert_instance_of GameTeam, @team
  end

  def test_it_has_attributes
    assert_equal 2012030221, @team.game_id
    assert_equal 3, @team.team_id
    assert_equal 'away', @team.hoa
    assert_equal 'LOSS', @team.result
    assert_equal 'OT', @team.settled_in
    assert_equal 'John Tortorella', @team.head_coach
    assert_equal 2, @team.goals
    assert_equal 8, @team.shots
    assert_equal 44, @team.tackles
    assert_equal 8, @team.pim
    assert_equal 3, @team.powerPlayOpportunities
    assert_equal 0, @team.powerPlayGoals
    assert_equal 44.8, @team.faceOffWinPercentage
    assert_equal 17, @team.giveaways
    assert_equal 7, @team.takeaways
  end

end
