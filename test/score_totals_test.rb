require 'minitest/autorun'
require 'minitest/pride'
require_relative 'game'
require_relative 'score_totals'

class ScoreTotalsTest < Minitest::Test
  def setup
    @game = Game.new({
      :game_id => "201203022015",
      :season => "20192020",
      :type => "Preseason",
      :date_time => "12/16/19",
      :away_team_id => "3",
      :home_team_id => "10",
      :away_goals => 4,
      :home_goals => 1,
      :venue => "Mercedes Benz Superdome"
      })
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
    @csv_game = @games[4]
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_instance_of Game, @game
    assert_equal "201203022015", @game.game_id
    assert_equal "20192020", @game.season
    assert_equal "Preseason", @game.type
    assert_equal "12/16/19", @game.date_time
    assert_equal "3", @game.away_team_id
    assert_equal "10", @game.home_team_id
    assert_equal 4, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal "Mercedes Benz Superdome", @game.venue
  end

  def test_it_reads_csv
    assert_instance_of Game, @csv_game
    assert_equal "2012030222", @csv_game.game_id
    assert_equal "20122013", @csv_game.season
    assert_equal "Postseason", @csv_game.type
    assert_equal "5/19/13", @csv_game.date_time
    assert_equal "3", @csv_game.away_team_id
    assert_equal "6", @csv_game.home_team_id
    assert_equal 2, @csv_game.away_goals
    assert_equal 3, @csv_game.home_goals
    assert_equal "Toyota Stadium", @csv_game.venue
  end
end
