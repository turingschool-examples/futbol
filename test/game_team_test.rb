require_relative 'test_helper'

class GameTeamTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def test_it_exists
    stat_tracker = StatTracker.new(@locations)
    gameteam = GameTeam.new(stat_tracker.game_teams)

    assert_instance_of GameTeam, gameteam
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.new(@locations)
    actual = stat_tracker.game_teams["2012030222"]

    assert_equal "home", actual.hoa
    assert_equal 48, actual.faceOffWinPercentage
    assert_equal 2012030222, actual.game_id
    assert_equal 3, actual.goals
    assert_equal "Claude Julien", actual.head_coach
    assert_equal 19, actual.pim
    assert_equal 0, actual.powerPlayGoals
    assert_equal 1, actual.powerPlayOpportunities
    assert_equal "WIN", actual.result
    assert_equal "REG", actual.settled_in
    assert_equal 8, actual.shots
    assert_equal 0, actual.tackles
    assert_equal 6, actual.takeaways
    assert_equal 6, actual.team_id
  end
end
