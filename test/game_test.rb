require "./test/test_helper.rb"
class Gametest < MiniTest::Test

  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_it_has_attributes
    game = Game.new


    assert_equal "2012030221", game.game_id
  end




end
