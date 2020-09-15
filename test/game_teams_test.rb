require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_teams_manager'
require './lib/game_teams'
require './test/test_helper'

class GameTeamsTest < Minitest::Test
  def setup
    @game_path = './fixture/game_teams_dummy.csv'

    @game_teams_manager = GameTeamsManager.new(@game_path,nil)
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams_manager.game_teams[0]
  end

  def test_it_has_attributes
    assert_equal '2012030221', @game_teams_manager.game_teams[0].game_id
    assert_equal '20122013', @game_teams_manager.game_teams[0].team_id
    assert_equal 'Postseason', @game_teams_manager.game_teams[0].hoa
    assert_equal '5/16/13', @game_teams_manager.game_teams[0].result
    assert_equal '3', @game_teams_manager.game_teams[0].settled_in
    assert_equal '6', @game_teams_manager.game_teams[0].head_coach
    assert_equal '2', @game_teams_manager.game_teams[0].goals
    assert_equal '3', @game_teams_manager.game_teams[0].shots
    assert_equal 'Toyota Stadium', @game_teams_manager.game_teams[0].tackles
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].power_play_opportunities
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].power_play_goals
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].face_off_win_percentage
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].giveaways
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].takeaways
    assert_equal '/api/v1/venues/null', @game_teams_manager.game_teams[0].manager
  end
end
