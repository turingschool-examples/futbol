require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'


class GameCollectionTest < Minitest::Test
  def setup
    @csv_file_path = "./test/fixtures/games_truncated.csv"
    @game_collection = GameCollection.new(@csv_file_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_equal [], @game_collection.games
    assert_equal "./test/fixtures/games_truncated.csv", @game_collection.csv_file_path
  end

  def test_it_instantiate_a_game_object
    info = {
      game_id: "2012030221", season: "20122013", type: "Postseason",
      date_time: "5/16/13", away_team_id: "3", home_team_id: "6", away_goals: "2",
      home_goals: "3", venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"
    }
    game = @game_collection.instantiate_game(info)

    assert_instance_of Game, game
    assert_equal 2012030221, game.game_id
    assert_equal "Postseason", game.type
    assert_equal "5/16/13", game.date_time
    assert_equal 3, game.away_team_id
  end

  def test_game_can_be_collected
    info = {
      game_id: "2012030221", season: "20122013", type: "Postseason",
      date_time: "5/16/13", away_team_id: "3", home_team_id: "6", away_goals: "2",
      home_goals: "3", venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"
    }
    game = @game_collection.instantiate_game(info)
    @game_collection.collect_game(game)

    assert_equal [game], @game_collection.games
  end

  def test_games_can_be_created_through_csv
    @game_collection.create_game_collection

    assert_instance_of Game, @game_collection.games.first
    assert_instance_of Game, @game_collection.games.last
    assert_equal 10, @game_collection.games.length
  end
end
