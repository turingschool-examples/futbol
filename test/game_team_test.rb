require_relative 'test_helper'
require 'mocha/minitest'

class GameTeamTest < Minitest::Test

  def setup
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({game_teams: game_teams_path})
  end

  def test_it_exists
    hash = {game_id: 8,
            team_id: 5,
                hoa: "away",
              result: "WIN",
          settled_in: "OT",
          head_coach: "Jose Lopez",
              goals: 7,
              shots: 15,
            tackles: 20,
                pim: 9,
powerPlayOpportunities: 3,
      powerPlayGoals: 3,
faceOffWinPercentage: 7,
          giveaways: 2,
            takeaways: 0}
    gameteam = GameTeam.new(hash)
    assert_instance_of GameTeam, gameteam
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.new
    assert_equal false, stat_tracker.game_team_table.include?("2012030222")
    actual = @stat_tracker.game_team_table[0]

    assert_equal "away", actual.hoa
    assert_equal 44, actual.faceOffWinPercentage
    assert_equal 2012030221, actual.game_id
    assert_equal 2, actual.goals
    assert_equal "John Tortorella", actual.head_coach
    assert_equal 8, actual.pim
    assert_equal 0, actual.powerPlayGoals
    assert_equal 3, actual.powerPlayOpportunities
    assert_equal "LOSS", actual.result
    assert_equal "OT", actual.settled_in
    assert_equal 8, actual.shots
    assert_equal 44, actual.tackles
    assert_equal 7, actual.takeaways
    assert_equal 3, actual.team_id
  end
end
