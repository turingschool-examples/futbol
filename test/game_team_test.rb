require_relative 'test_helper'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @game_teams = GameTeam.create_game_teams('./test/fixtures/game_teams_truncated.csv')
    @game_team = GameTeam.all[2]

  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_attributes
    assert_equal 2012030222, @game_team.game_id
    assert_equal 3, @game_team.team_id
    assert_equal 'away', @game_team.hoa
    assert_equal 'LOSS', @game_team.result
    assert_equal 'REG', @game_team.settled_in
    assert_equal 'John Tortorella', @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 9, @game_team.shots
    assert_equal 33, @game_team.tackles
    assert_equal 11, @game_team.pim
    assert_equal 5, @game_team.power_play_opportunities
    assert_equal 0, @game_team.power_play_goals
    assert_equal 51.7, @game_team.face_off_win_percentage
    assert_equal 1, @game_team.giveaways
    assert_equal 4, @game_team.takeaways
  end


end
