require 'csv'
require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    csv = CSV.read('./data/games_sample.csv', headers: true, header_converters: :symbol)
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
    assert_equal 2012030221, @games.first.game_id
    assert_equal 20122013, @games.first.season
    assert_equal "Postseason", @games.first.type
    assert_equal "5/16/13", @games.first.date_time
    assert_equal 3, @games.first.away_team_id
    assert_equal 6, @games.first.home_team_id
    assert_equal 2, @games.first.away_goals
    assert_equal 3, @games.first.home_goals
    assert_equal "Toyota Stadium", @games.first.venue
    assert_equal "/api/v1/venues/null", @games.first.venue_link
  end
end
