require_relative './test_helper'
require './lib/game_team'
require './lib/game_teams_collection'
require './lib/stat_tracker'


class GameTeamTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stattracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_has_attributes
    gameteam = @stattracker.game_teams.game_teams.first
    assert_instance_of GameTeam, gameteam
    assert_equal "2012030221", gameteam.game_id
    assert_equal "3", gameteam.team_id
    assert_equal "away", gameteam.hoa
    assert_equal "LOSS", gameteam.result
    assert_equal "John Tortorella", gameteam.head_coach
    assert_equal 2, gameteam.goals
    assert_equal 8, gameteam.shots
    assert_equal 44, gameteam.tackles
  end
end
