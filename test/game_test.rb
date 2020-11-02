require './test/test_helper'
require './lib/game'
class GameTest < Minitest::Test
  def setup
    @game = Game.new({
      game_id: 2012030221,
      season: "20122013",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
    })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_equal 2012030221, @game.id
    assert_equal "20122013", @game.season
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_home_win
    assert @game.home_win?
  end

  def test_away_win
    refute @game.visitor_win?
  end

  def test_tie?
    refute @game.tie?
  end

  def test_total_score
    assert_equal 5, @game.total_score
  end

  def test_win?
    assert_equal false, @game.win?(3)
    assert_equal true, @game.win?(6)
    new_game = Game.new({away_goals: 3,
                        away_team_id: 14,
                        home_goals: 1,
                        home_team_id: 1,
                        id: 2017030114,
                        season: "20172018"})
    assert_equal true, new_game.win?(14)
  end

  def test_match?
    assert_equal false, @game.match?(14)
    assert_equal true, @game.match?(3)
  end

  def test_away?
    assert_equal false, @game.away?(6)
    assert_equal true, @game.away?(3)
  end

  def test_home?
    assert_equal false, @game.home?(3)
    assert_equal true, @game.home?(6)
  end
end
