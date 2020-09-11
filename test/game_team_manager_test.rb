require './test/test_helper'
require './lib/game_team_manager'
require 'pry'

class GameTeamManagerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @game_team_manager = GameTeamManager.new(@locations, @stat_tracker)
    @game_team_manager.generate_game_teams(@locations[:game_teams])
  end

  def test_game_teams_data_for_season

    assert_equal 1612, @game_team_manager.game_teams_data_for_season('20122013').length
    assert_equal '2012030221', @game_team_manager.game_teams_data_for_season('20122013')[0].game_id
    assert_equal 'Todd McLellan', @game_team_manager.game_teams_data_for_season('20122013')[-1].head_coach
  end
end
