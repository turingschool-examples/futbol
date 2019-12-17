require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'

class GamesTest < Minitest::Test
  def setup
    @game = Games.new({})
    @game_path = './data/games.csv'
    @games = Games.from_csv(@game_path)
    @csv_game = @games[1]
    require "pry"; binding.pry
  end

  def test_it_exists
    assert_instance_of Games, @game
  end

  def test_it_has_attributes
    skip
  end

  def test_it_reads_csv
    assert_instance_of Games, @csv_game
    assert_equal "2012030222", @csv_game.game_id
    assert_equal "20122013", @csv_game.season
    assert_equal "Postseason", @csv_game.type
    assert_equal "5/19/13", @csv_game.date_time
    assert_equal "3", @csv_game.away_team_id
    assert_equal "6", @csv_game.home_team_id
    assert_equal "2", @csv_game.away_goals
    assert_equal "3", @csv_game.home_goals
    assert_equal "Toyota Stadium", @csv_game.venue
  end
end
