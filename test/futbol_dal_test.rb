require "minitest/autorun"
require "minitest/pride"
require "./lib/futbol_dal"

class FutbolDALTest < Minitest::Test
  def test_it_exists
    info = {
            game: "./test/fixtures/games_truncated.csv",
            team: "./test/fixtures/teams_truncated.csv",
            game_team: "./test/fixtures/game_teams_truncated.csv"
            }
    futbol_dal = FutbolDAL.from_csv(info)

    assert_instance_of FutbolDAL, futbol_dal
  end

  def test_it_has_attributes
    info = {
            game: "./test/fixtures/games_truncated.csv",
            team: "./test/fixtures/teams_truncated.csv",
            game_team: "./test/fixtures/game_teams_truncated.csv"
            }
    futbol_dal = FutbolDAL.from_csv(info)

    assert_instance_of TeamCollection, futbol_dal.team_collection
    assert_instance_of GameCollection, futbol_dal.game_collection
    assert_instance_of GameTeamCollection, futbol_dal.game_team_collection
  end
end
