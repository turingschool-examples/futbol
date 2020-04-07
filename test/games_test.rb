require_relative 'test_helper'


class GameTest < Minitest::Test
  def setup
    @info = {
      :game_id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3
    }

    @game = Game.new(@info)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal "2012030221", @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end
end
