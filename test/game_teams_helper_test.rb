require "./test/test_helper"
require './lib/game_teams_manager'
require './lib/game_teams_helper'
require 'pry';
require 'mocha/minitest'

class GameTeamsHelperTest < Minitest::Test
  def setup
    manager = mock('manager')
    manager.stubs(:class).returns(GameTeamsManager)
    @game_team_helper = GameTeamsHelper.new(manager)
  end

  def test_return_total_goals_by_team
    @game_team_helper.stubs(:goals).returns([20])
    assert_equal 20.0, @game_team_helper.total_goals('6')
  end
end
