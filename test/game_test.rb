require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/stat_tracker'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    # file_path = "./data/games.csv"
    file_path = "./test/fixtures/short_games.csv"
    @games = Game.from_csv(file_path)

    @base_game = Game.new({
      :game_id => 2012030222,
      :season => 20122013,
      :type => "Postseason",
      :date_time => "5/19/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
      })
  end

  def test_it_exists
    assert_instance_of Game, @base_game
  end

  def test_it_returns_list_of_games
    assert_instance_of Array, Game.all
    assert_equal 4, Game.all.length
    assert_instance_of Game, Game.all.first
  end

  def test_it_returns_attributes
    assert_equal 2012030222, @base_game.game_id
    assert_equal 20122013, @base_game.season
    assert_equal "Postseason", @base_game.type
    assert_equal "5/19/13", @base_game.date_time
    assert_equal 3, @base_game.away_team_id
    assert_equal 6, @base_game.home_team_id
    assert_equal 2, @base_game.away_goals
    assert_equal 3, @base_game.home_goals
    assert_equal "Toyota Stadium", @base_game.venue
    assert_equal "/api/v1/venues/null", @base_game.venue_link
  end

  def test_it_returns_attributes_from_collection
    assert_equal 2012030222, @games[1].game_id
    assert_equal 20122013, @games[1].season
    assert_equal "Postseason", @games[1].type
    assert_equal "5/19/13", @games[1].date_time
    assert_equal 3, @games[1].away_team_id
    assert_equal 6, @games[1].home_team_id
    assert_equal 2, @games[1].away_goals
    assert_equal 3, @games[1].home_goals
    assert_equal "Toyota Stadium", @games[1].venue
    assert_equal "/api/v1/venues/null", @games[1].venue_link
  end




end
