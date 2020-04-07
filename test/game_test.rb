require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "pry"

class GameTest < Minitest::Test

  def setup
    @base_game = Game.new({:game_id => 123,
                :season => 456,
                :type => "good",
                :date_time => "12/20/20",
                :away_team_id => 45,
                :home_team_id => 36,
                :away_goals => 3,
                :home_goals => 3,
                :venue => "Heaven",
                :venue_link => "venue/link"})

    Game.from_csv('./data/fixtures/short_games.csv')
    @game = Game.all[0]
  end

  def test_it_exists
    assert_instance_of Game, @base_game
  end

  def test_it_has_attributes
    assert_equal 123, @base_game.game_id
    assert_equal 456, @base_game.season
    assert_equal "good", @base_game.type
    assert_equal "12/20/20", @base_game.date_time
    assert_equal 45, @base_game.away_team_id
    assert_equal 36, @base_game.home_team_id
    assert_equal 3, @base_game.away_goals
    assert_equal 3, @base_game.home_goals
    assert_equal "Heaven", @base_game.venue
    assert_equal "venue/link", @base_game.venue_link
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
    assert_equal 4, Game.all.length
    assert_instance_of Game, Game.all.first
  end

  def test_it_returns_average_goals_per_game
    assert_equal 4.5, Game.average_goals_per_game
  end

  # def test_it_returns_goals_by_season
  #   Game.from_csv('./data/fixtures/games_2_seasons.csv')
  #   expected = {20122013=>220, 20162017=>19}
  #   assert_equal expected, Game.oals_by_season
  # end
  #
  # def test_it_returns_total_games_by_season
  #   Game.from_csv('./data/fixtures/games_2_seasons.csv')
  #   expected = {20122013=>57, 20162017=>4}
  #   assert_equal expected, Game.games_by_season
  # end

  def test_games_per_season
    Game.from_csv('./data/fixtures/games_2_seasons.csv')
    assert_equal [57, 4], Game.games_per(:season)
  end
  def test_goals_per_season
    Game.from_csv('./data/fixtures/games_2_seasons.csv')
    assert_equal [220, 19], Game.goals_per(:season)
  end


  def test_average_goals_by_season
    Game.from_csv('./data/fixtures/games_2_seasons.csv')
    expected = [20122013, 20162017]
    assert_equal expected, Game.average_goals_by_season
  end
end
