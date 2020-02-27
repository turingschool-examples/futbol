require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @test_data = CSV.read('./data/little_games.csv', headers: true, header_converters: :symbol)
    @games = @test_data.map do |row|
      Game.new(row.to_h)
    end
  end

  def test_it_exists
    assert_instance_of Game, @games.first
  end

  def test_it_contains_game_data
    assert_equal "2012030221", @games.first.game_id
    assert_equal "20122013", @games.first.season
    assert_equal 3, @games.first.away_team_id
    assert_equal 6, @games.first.home_team_id
    assert_equal 2, @games.first.away_goals
    assert_equal 3, @games.first.home_goals
  end

end
