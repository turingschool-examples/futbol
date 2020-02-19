require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team"

class GameTeamTest < Minitest::Test

  def test_that_it_exists
    info = {game_id: "2012030221",team_id: "3",
            HoA: "away",result: "LOSS",settled_in: "OT",
            head_coach: "John Tortorella",goals: "2",shots: "8",
            tackles: "44",pim: "8",powerPlayOpportunities: "3",
            powerPlayGoals: "0",faceOffWinPercentage: "44.8",
            giveaways: "17",takeaways: "7"}
    game_team = GameTeam.new(info)

    assert_instance_of GameTeam, game_team
  end
end
