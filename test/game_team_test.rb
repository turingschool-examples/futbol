require_relative 'test_helper'
require_relative '../lib/game_team'

class GameTeamTest < Minitest::Test
  def setup
    @new_game_team = GameTeam.new({
      team_id: '3',
      HoA: 'away',
      result: 'LOSS',
      settled_in: 'OT',
      head_coach: 'John Tortorella',
      goals: '2',
      shots: '8',
      tackles: '44',
      giveaways: '17',
      takeaways: '7'
    })
  end

  def test_game_team_exists
    assert_instance_of GameTeam, @new_game_team
  end

  def test_game_team_has_attributes
    assert_instance_of GameTeam, @new_game_team
    assert_equal '3', @new_game_team.team_id
    assert_equal 'John Tortorella', @new_game_team.head_coach
  end
end
