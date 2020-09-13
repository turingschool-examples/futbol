require './test/test_helper'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test
  def test_it_exists
    game_teams = './data/game_teams.csv'

    game_team = nil
    CSV.foreach(game_teams, headers: true).map do |row|
      game_team = GameTeams.new(row)
      break
    end
      assert_instance_of GameTeams, game_team
  end

  def test_it_has_attributes
    game_teams = './data/game_teams.csv'

    game_team = nil
    CSV.foreach(game_teams, headers: true).map do |row|
      game_team = GameTeams.new(row)
      break
    end
    assert_equal "2012030221", game_team.game_id
    assert_equal "3", game_team.team_id
    assert_equal "away", game_team.hoa
    assert_equal "LOSS", game_team.result
    assert_equal "OT", game_team.settled_in
    assert_equal "John Tortorella", game_team.head_coach
    assert_equal "2", game_team.goals
    assert_equal "8", game_team.shots
    assert_equal "44", game_team.tackles
    assert_equal "8", game_team.pim
    assert_equal "3", game_team.power_play_opportunities
    assert_equal "0", game_team.power_play_goals
    assert_equal "44.8", game_team.face_off_win_percentage
    assert_equal "17", game_team.giveaways
    assert_equal "7", game_team.takeaways
  end
end
