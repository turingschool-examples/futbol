require "./test/test_helper"
require './lib/stat_tracker'
# require "./lib/game_statistics"
require './lib/game_manager'
require './lib/game'
require 'mocha/minitest'
require "pry";

class GameTest < Minitest::Test
  def setup
    data = {
            "game_id" => "2012030225",
            "season" => "20122013",
            "type" => "Postseason",
            "date_time" => "5/25/13",
            "away_team_id" => "3",
            "home_team_id" => "6",
            "away_goals" => "1",
            "home_goals" => "3",
            "venue" => "Toyota Stadium",
            "venue_link" => "/api/v1/venues/null"
            }
    manager = mock('GamesManager')
    @game = Game.new(data, manager)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_can_find_total_score
    assert_equal 4, @game.total_score
  end

end
