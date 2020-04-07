require_relative 'test_helper'


class GameTest < Minitest::Test
  def setup
    info = {
      :game_id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3
    }

    @game = Game.new(info)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end
end
