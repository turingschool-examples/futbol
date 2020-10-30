require_relative './test_helper'
require './lib/game'
require 'csv'

class GameTest < Minitest::Test

  def setup
    @parent = mock("Game Collection")
    @parent.stubs(:parent => "Parent")
    @games = []
      CSV.foreach('./data/games_dummy.csv', headers: true, header_converters: :symbol) do |row|
      @games << Game.new(row, @parent)
    end
  end

  def test_it_exists_and_has_attributes
    game = @games.first
    assert_instance_of Game, game
    assert_equal "2012030221", game.game_id
    assert_equal "20122013", game.season
    assert_equal "Postseason", game.type
    assert_equal "5/16/13", game.date_time
    assert_equal 3, game.away_team_id
    assert_equal 6, game.home_team_id
    assert_equal 2, game.away_goals
    assert_equal 3, game.home_goals
    assert_equal "Toyota Stadium", game.venue
  end

  def test_total_score
    game = @games.first
    assert_equal 5, game.total_score
  end
end
