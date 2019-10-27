require 'csv'
require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    csv = CSV.read('./test/data/games_sample.csv', headers: true, header_converters: :symbol)
    @games = csv.map do |row|
      Game.new(row)
    end
  end

  def test_it_exists
    @games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_it_has_attributes
    game = @games.first
    assert_equal "2017030110", game.game_id
    assert_equal "20172018", game.season
    assert_equal "Postseason", game.type
    assert_equal "4/16/18", game.date_time
    assert_equal "4", game.away_team_id
    assert_equal "1", game.home_team_id
    assert_equal 2, game.away_goals
    assert_equal 3, game.home_goals
    assert_equal "Mercedes-Benz Stadium", game.venue
  end
end
