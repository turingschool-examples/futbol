require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game'


class GameTest < Minitest::Test
  def test_it_exists
  #game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link
  game = Game.new({game_id: 123, season: "20122013", type: "Postseason", date_time: "6/5/13", away_team_id: 1, home_team_id: 1, away_goals: 1, home_goals: 1, venue: "Toyta", venue_link: "link" })
  assert_instance_of Game, game
  end
  def test_has_attributes
    game = Game.new({game_id: 123, season: "20122013", type: "Postseason", date_time: "6/5/13", away_team_id: 1, home_team_id: 1, away_goals: 1, home_goals: 1, venue: "Toyta", venue_link: "link" })
    assert_equal 123, game.game_id
    assert_equal "20122013", game.season
    assert_equal "Postseason", game.type
    assert_equal "6/5/13", game.date_time
    assert_equal 1, game.away_team_id
    assert_equal 1, game.home_team_id
    assert_equal 1, game.away_goals
    assert_equal 1, game.home_goals
    assert_equal "Toyta", game.venue
    assert_equal "link", game.venue_link
  end

end
