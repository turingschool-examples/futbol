require "minitest/autorun"
require "minitest/pride"
require "./lib/futbol_data"

class FutbolDataTest < Minitest::Test

  def test_create_chosen_data_set_for_team
    futbol = FutbolData.new("team")
    futbol.all_teams
  end

  def test_create_chosen_data_set_for_game
    skip
    futbol = FutbolData.new("game")
    assert_equal "", futbol.create_objects
  end

  def test_create_chosen_data_set_for_game_team
    skip
    futbol = FutbolData.new("game_team")
    assert_equal "", futbol.create_objects
  end

end
