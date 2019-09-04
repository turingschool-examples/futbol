require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game_hash = {
      id: 2012030221,
      season: 20122013,
      type: "Postseason",
      date_time: "5/16/13",
      venue: "Toyota Stadium",
      venue_link: "/api/v1/venues/null",
      home_team: {id: 6},
      away_team: {id: 3}
    }
    @game = Game.new(@game_hash)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_attributes
    assert_equal @game_hash[:id], @game.id
    assert_equal @game_hash[:season], @game.season
    assert_equal @game_hash[:type], @game.type
    assert_equal @game_hash[:date_time], @game.date_time
    assert_equal @game_hash[:venue], @game.venue
    assert_equal @game_hash[:venue_link], @game.venue_link
    assert_equal @game_hash[:home_team][:id], @game.home_team[:id]
    assert_equal @game_hash[:away_team][:id], @game.away_team[:id]
  end
end
