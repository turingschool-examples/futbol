require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './test/setup'

class GameTest < Minitest::Test
  def setup
    game_params = {game_id: "2012030221",
                    season: "20122013",
                    away_team_id: "3",
                    home_team_id: "6",
                    away_goals: "2",
                    home_goals: "3"}
    @game = Game.new(game_params)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal 5, @game.total_goals
  end

  def test_can_create_all_games_from_csv
    game_path = './fixtures/games_fixture.csv'
    games = Game.all(game_path)
    assert_instance_of Array, games
    assert_equal 5, games.count
  end

end
