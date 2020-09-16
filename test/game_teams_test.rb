require_relative 'test_helper'

class GameTeamsTest < Minitest::Test
  def setup
    @hash = {
      game_id: '2012030221',
      team_id: '3',
      HoA: 'away',
      result: 'LOSS',
      settled_in: 'OT',
      head_coach: 'John Tortorella',
      goals: '2',
      shots: '8',
      tackles: '44'
    }

    @game_teams = GameTeams.new(@hash)
  end

  def test_it_exists_with_attributes
    assert_instance_of GameTeams, @game_teams
  end
end
