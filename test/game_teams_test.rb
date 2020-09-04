require "./lib/game_teams"
require "./test/test_helper"

class GameTeamsTest < Minitest::Test
  def test_it_can_read_from_csv
    GameTeams.from_csv

    assert_equal 12, GameTeams.all_game_teams.count
  end
end
