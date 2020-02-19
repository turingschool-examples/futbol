require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'csv'
require './lib/stat_tracker'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    StatTracker.create_items("./test/fixtures/games_sample.csv", Game)
    @game = Game.all

    @new_game = Game.new({
      game_id: 2012030221,
      season: 20122013,
      type: "Postseason",
      date_time: "5/16/13",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
      venue: "Toyota Stadium",
      venue_link: "/api/v1/venues/null"
      })
  end

  def test_it_exists
    game = Game.new({})
    assert_instance_of Game, game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @new_game.game_id
    assert_equal 20122013, @new_game.season
    assert_equal "Postseason", @new_game.type
    assert_equal "5/16/13", @new_game.date_time
    assert_equal 3, @new_game.away_team_id
    assert_equal 6, @new_game.home_team_id
    assert_equal 2, @new_game.away_goals
    assert_equal 3, @new_game.home_goals
    assert_equal "Toyota Stadium", @new_game.venue
    assert_equal "/api/v1/venues/null", @new_game.venue_link
  end

  def test_it_can_add_game
    assert_instance_of Hash, Game.all
    assert_equal 100, Game.all.length
    assert_instance_of Game, Game.all[2012030221]

    assert_equal 2012030221, Game.all[2012030221].game_id
    assert_equal "5/16/13", Game.all[2012030221].date_time
    assert_equal 20122013, Game.all[2012030221].season
  end

end
