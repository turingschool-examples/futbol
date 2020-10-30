require "minitest/autorun"
require "minitest/pride"
require "./lib/model/game_team"

class GameTeamTest < Minitest::Test

  def setup
    row = {
      game_id: "2012030111",
      team_id: "2",
      hoa: "away",
      result: "LOSS",
      settled_in: "REG",
      head_coach: "Jack Capuano",
      goals: "3",
      shots: "6",
      tackles: "36"
      }
  end
end
