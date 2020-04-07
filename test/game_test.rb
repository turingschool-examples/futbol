require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "pry"

class GameTest < Minitest::Test

  def setup
    @new_game = Game.new({:game_id => 123,
                :season => 456,
                :type => "good",
                :date_time => "12/20/20",
                :away_team_id => 45,
                :home_team_id => 36,
                :away_goals => 3,
                :home_goals => 3,
                :venue => "Heaven",
                :venue_link => "venue/link"})

    Game.from_csv('./data/games.csv')
    @game = Game.all[0]
  end

  def test_it_exists
    assert_instance_of Game, @new_game
  end

  def test_it_has_attributes
    assert_equal 123, @new_game.game_id
    assert_equal 456, @new_game.season
    assert_equal "good", @new_game.type
    assert_equal "12/20/20", @new_game.date_time
    assert_equal 45, @new_game.away_team_id
    assert_equal 36, @new_game.home_team_id
    assert_equal 3, @new_game.away_goals
    assert_equal 3, @new_game.home_goals
    assert_equal "Heaven", @new_game.venue
    assert_equal "venue/link", @new_game.venue_link
  end

  def test_it_can_create_game_from_csv
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_it_has_all
    assert_instance_of Array, Game.all
    assert_equal 7441, Game.all.length
    assert_instance_of Game, Game.all.first
  end
end
