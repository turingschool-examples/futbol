require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game'
require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game_path = './fixture/games_dummy.csv'

    @game_manager = GameManager.new(@game_path,nil)
  end

  def test_it_exists
    assert_instance_of Game, @game_manager.games[0]
  end

  # def test_it_has_attributes
  #   path = './data/teams.csv'
  #   team = Team.new(path, nil)

  #   assert_equal '1', @team_manager.teams[0].team_id
  #   assert_equal '23', @team_manager.teams[0].franchise_id
  #   assert_equal 'Atlanta United', @team_manager.teams[0].team_name
  #   assert_equal 'ATL', @team_manager.teams[0].abbreviation
  #   assert_equal 'Mercedes-Benz Stadium', @team_manager.teams[0].stadium
  #   assert_equal '/api/v1/teams/1', @team_manager.teams[0].link
  # end
end
