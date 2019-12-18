require_relative 'test_helper'
require_relative '../lib/games'

class GamesTest < Minitest::Test
  def setup
    @games = Games.new({})
  end

  def test_games_exists
    assert_instance_of Games, @games
  end

  def test_games_has_attributes
    # insert tests for games attributes
    #   determine what attributes will
    #   need to be tested.
  end
end
