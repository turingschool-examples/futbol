require_relative 'test_helper'
require_relative '../lib/helpable'
require 'mocha/minitest'

class GameTeamsManagerTest < Minitest::Test
  include Helpable

  def test_it_exists
    game_teams_manager = GameTeamsManager.new(setup)

    assert_instance_of GameTeamsManager, game_teams_manager
  end

  def test_percentage_home_wins
    game_teams_manager = GameTeamsManager.new(setup)

    assert_equal 0.57, game_teams_manager.percentage_home_wins
  end

  def test_percentage_visitor_wins
    game_teams_manager = GameTeamsManager.new(setup)

    assert_equal 0.36, game_teams_manager.percentage_visitor_wins
  end

end
